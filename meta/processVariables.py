# reads object files from stdin, reads all variables and invokes callback.

import regex
import statistics
import os
import sys

srevarname = "[a-zA-Z_][a-zA-Z0-9_]*"

reFindVars = regex.compile(r"\s*(" + srevarname + "\.)?(" + srevarname + ")(\[.*\])? *=(?!=)")
reFindLocals = regex.compile(r"\s*var (\s*(" + srevarname + ")\s*(=[^,;]+\s*)?,?)+")
reParent = regex.compile(r"<parentName>([^<]*)</parentName>")
reObjectFileParse = regex.compile(r"(.*)\.object\.gmx")

builtin = {'hspeed', 'vspeed', 'solid', 'visible', 'persistent', 'depth', 'alarm', 'object_index',
			'sprite_index', 'image_index', 'image_alpha', 'image_angle', 'image_blend',
			'image_speed', 'image_xscale', 'image_yscale', 'image_single', 'mask_index', 'friction',
			'gravity', 'gravity_direction', 'direction', 'hspeed', 'vspeed', 'speed', 
			'x', 'y', 'xprevious', 'yprevious', 'xstart', 'ystart',
			'background_colour', 'background_color', 'view_xview', 'view_yview', 'view_wview', 'view_hview', 'view_visible',
			'view_enabled', 'room_speed', 'background_visible'}
			
class ObjectParseResult:
	def __init__(self):
		self.name = ""
		self.path = ""
		# parse result for parent.
		self.parentResult = None
		# variables which are declared in a var statement.
		self.localVariables = []
		# instance variables that any ancestor of this object had.
		self.instanceVariablesInherited = []
		# any instance variable in object that is not inherited nor local.
		self.instanceVariables = []
		# of the above, those which were not mentioned in the create event.
		self.instanceVariablesQuestionable = []
		# any instance variable that is not inherited, local, or questionable.
		self.instanceVariablesDefinite = []
		# union of instanceVariables and instanceVariablesInherited.
		self.instanceVariablesAll = []
		# this and any ancestor's definite instance variable.
		self.instanceVariablesDefiniteAll = []
		
def walkObjects(directory, verbose=False, ignore=None):
	# yields ObjectParseResults for all objects in the given directory.
	# verbose: print to stdout
	# ignore: variables names to ignore (built-in variables are always ignored)
	if len(sys.argv) <= 1:
		print("usage: " + sys.argv[0] + " object-directory")

	if ignore is None:
		ignore = builtin
	else:
		ignore |= builtin
		
	dir = sys.argv[-1]
	needs_processing = list(map(lambda p : os.path.join(dir, p), os.listdir(dir)))
	processed = []
	process_count = len(needs_processing)

	objvars = {}
	results = {}
	instanceVarCounts = []
	questionableVarCounts = []
	localVarCounts = []
	
	while len(needs_processing) > 0:
		objFile = needs_processing.pop(0).strip()
		objFileNameMatch = reObjectFileParse.match(objFile)
		if objFileNameMatch is None:
			continue
		result = None
		with open(objFile, "r", encoding="utf8") as f:
			fcontents = f.read()
			parentMatch = reParent.search(fcontents)
			parentFile = None
			if parentMatch is not None:
				parent = parentMatch.group(1)
				if parent != "" and parent != "&lt;undefined&gt;":
					# put objFile back on list and process parent instead
					parentFile = os.path.join(os.path.dirname(objFile), parent + ".object.gmx")
					if parentFile not in processed:
						needs_processing.append(objFile)
						if parentFile in needs_processing:
							needs_processing.remove(parentFile)
						needs_processing.insert(0, parentFile)
						continue
					
			result = ObjectParseResult()
			result.name = objFileNameMatch.group(1)
			result.path = objFile
			if parentFile is not None:
				result.parentResult = results[parentFile]
			
			# find create event
			createStart = fcontents.find("<event eventtype=\"0\" enumb=\"0\">")
			createEnd = -1
			if createStart >= 0:
				createEnd = fcontents.find("</event>", createStart)
			
			# find comments
			commentSpans = parseComments(fcontents, objFile.endswith(".object.gmx"))
			
			# find all with () { ... } ranges
			withSpans = parseWiths(fcontents)
			
			# find variable names
			vars = set()
			locals = set()
			definite = set()
			
			for match in reFindVars.finditer(fcontents):
				varName = match.group(2)
				# ignore comments
				if inFlatSpans(match.span()[0], commentSpans):
					continue
				# var belonging to other objects or global, e.g. t.xspeed, global.health
				varInstance = len(match.captures(1)) == 0
				varOther = False
				if "other." in match.captures(1):
					# could potentially be other.other
					varInstance = True
					varOther = True
				if varInstance:
					# check with spans to see if this is definitely being assigned to a different instance.
					withsTreeLocation = locateInWithsTree(match.span()[0], withSpans)
					if len(withsTreeLocation) > 0:
						if withsTreeLocation[-1] != "other" and withsTreeLocation[-1] != "(other)":
							continue
							
					# check if var assigned to other at top-level
					if len(withsTreeLocation) == 0:
						if varOther:
							continue
							
					# possibly an instance variable.
					vars.add(varName)
					if match.span()[0] < createEnd:
						definite.add(varName)
			for match in reFindLocals.finditer(fcontents):
				# list of vars declared in this var statement (can be more than one!)
				localDecls = match.captures(2)
				for local in localDecls:
					locals.add(local)
			vars -= locals
			vars -= ignore
			locals -= ignore
			objvars[objFile] = vars.copy()
			if parentFile is not None:
				vars -= objvars[parentFile]
				objvars[objFile] |= objvars[parentFile]
				
			definite &= vars
			questionable = vars - definite

			if verbose and len(questionable) > 0:
				print(objFile)
				print("\"with\" statements:", withSpans)
				if parentFile is not None:
					if verbose:
						print("> inherits from ({})".format(parent))
				for var in vars:
					if var not in questionable:
						print("*       {}".format(var))
				for var in questionable:
					print("?       {}".format(var))
				for local in locals:
					print("(local) {}".format(local))
				print()
				instanceVarCounts.append(len(vars))
				questionableVarCounts.append(len(questionable))
				localVarCounts.append(len(locals))
			
			result.localVariables = locals
			result.instanceVariables = vars
			result.instanceVariablesQuestionable = questionable
			result.instanceVariablesDefinite = vars - questionable
			if parentFile is not None:
				result.instanceVariablesInherited   = objvars[parentFile]
				result.instanceVariablesAll         = vars                             | result.parentResult.instanceVariablesAll
				result.instanceVariablesDefiniteAll = result.instanceVariablesDefinite | result.parentResult.instanceVariablesDefiniteAll
			else:
				result.instanceVariablesAll         = vars
				result.instanceVariablesDefiniteAll = result.instanceVariablesDefinite
			
		processed.append(objFile)
		if verbose:
			print (" "*50, round(100 - 100 * len(needs_processing) / process_count, 1), "%")
		if result is not None:
			results[objFile] = result
			yield result
	
	if verbose:
		print("Stats:")
		print("mean instance vars: ", round(statistics.mean(instanceVarCounts), 2))
		print("mean questionable:", round(statistics.mean(questionableVarCounts), 2))
		print("mean locals:", round(statistics.mean(localVarCounts), 2))
		print()
		print("median instance vars: ", statistics.median(instanceVarCounts))
		print("median questionable: ", statistics.median(questionableVarCounts))
		print("median locals: ", statistics.median(localVarCounts))

def matchBrace(code, index=0):
	# finds index of matching brace for brace at given index
	braces = 0
	comment = 0
	for i in range(index, len(code)):
		c = code[i]
		c2 = code[i:min(i+2, len(code))]
		if comment == 0:
			if c2 == '//':
				comment = 1
			if c2 == '/*':
				comment = 2
			elif c == '{':
				braces += 1
			elif c == '}':
				braces -= 1
				if braces == 0:
					return i
		elif comment == 1:
			if c2 == '\n':
				comment = 0
		elif comment == 2:
			if c2 == '*/':
				comment = 0
	return -1
		
def locateInWithsTree(pos, withTree):
	location = []
	for span in withTree:
		if pos >= span[0] and pos <= span[1]:
			location = [span[2]]
			location.extend(locateInWithsTree(pos, span[3]))
			break
		if pos < span[0]:
			break
	return location
		
reWithBody = regex.compile(r"with(([\s\n]*|\()[^\{\n]*)[\s\n]*\{", regex.MULTILINE)
def parseWiths(code, start=0, end=-1):
	# returns list of tuples of (start:int, end:int, withid:string, subwiths:list)
	spans = []
	withSearchStart = start
	while True:
		match = reWithBody.search(code, withSearchStart)
		if match is None:
			break
		if end != -1 and match.span()[1] > end:
			break
		bodyStart = match.span()[1]
		braceIndex = matchBrace(code, bodyStart - 1)
		if braceIndex != -1:
			spans.append((bodyStart, braceIndex, match.group(1).strip(), parseWiths(code, bodyStart, braceIndex)))
			# check for nested spans
			withSearchStart = braceIndex
		else:
			break
	return spans
		
def inFlatSpans(pos, spans):
	for span in spans:
		if pos < span[0]:
			return False
		if pos >= span[0] and pos < span[1]:
			return True
	return False
		
		
def parseComments(code, xmlAreComments=False, start=0):
	# returns flat span of comments
	spans = []
	while True:
		nextCommentSL = code.find("//", start)
		nextCommentML = code.find("/*", start)
		nextCommentXML = code.find("<", start)
		if not xmlAreComments:
			nextCommentXML = -1
		if (nextCommentSL < nextCommentML or nextCommentML == -1) and (nextCommentSL < nextCommentXML or nextCommentXML == -1) and nextCommentSL != -1:
			prev = nextCommentSL
			start = code.find("\n", nextCommentSL) + 1
			span = (prev, start - 1)
			if start == 0:
				span = (prev, len(code))
				spans.append(span)
				break
			spans.append(span)
		elif (nextCommentML <= nextCommentSL or nextCommentSL == -1) and (nextCommentML < nextCommentXML or nextCommentXML == -1) and nextCommentML != -1:
			prev = nextCommentML
			start = code.find("*/", nextCommentML) + 1
			span = (prev, start)
			if start == 0:
				span = (prev, len(code))
				spans.append(span)
				break
			spans.append(span)
		elif (nextCommentXML <= nextCommentSL or nextCommentSL == -1) and (nextCommentXML <= nextCommentML or nextCommentML == -1) and nextCommentXML != -1:
			prev = nextCommentXML + 1
			start = prev
			if prev >= len(code) - 2:
				break
			if code[prev] == '/':
				continue
			endb = code.find(">", prev)
			if endb == -1:
				continue
			start = endb + 1
			spans.append((prev, endb))
		else:
			break
	return spans
		
if __name__ == '__main__':
	if len(sys.argv) <= 1:
		print("usage: ./processVariables.py object-directory")
	else:
		for result in walkObjects(sys.argv[-1], True):
			pass