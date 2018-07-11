__remap = {
    "MM1": "<i>Mega Man</i>",
    "MM2": "<i>Mega Man 2</i>",
    "MM3": "<i>Mega Man 3</i>",
    "MM4": "<i>Mega Man 4</i>",
    "MM5": "<i>Mega Man 5</i>",
    "MM6": "<i>Mega Man 6</i>",
    "MM7": "<i>Mega Man 7</i>",
    "MM8": "<i>Mega Man 8</i>",
    "MM9": "<i>Mega Man 9</i>",
    "MM10": "<i>Mega Man 10</i>",
    "MM11": "<i>Mega Man 11</i>",
    "MMV": "<i>Mega Man V</i> (Gameboy)",
    "GB": "Gameboy games",
    "CFTF": "<i>Rockman & Forte: Challenger From the Future</i>"
}

sidebar.title = object.name[3:]
enemyRoot = "objects/Enemies/"
minibossRoot = "objects/Minibosses/"
bossRoot = "objects/Bosses/"
gimmickRoot = "objects/Gimmicks/"

# Enemies
if object.assetPath.startswith(enemyRoot):
    next = object.assetPath[len(enemyRoot):]
    pos = next.find("/")
    sidebar.collapseInfo = [[]]
    if pos != -1:
        name = next[:pos]
        if name in __remap:
            name = __remap[name]
            sidebar.collapseInfo[0] += [
              ("Origin", name)
            ]
    sidebar.enabled = True
    sidebar.collapseTitles = ["Enemy Information"]
    sidebar.collapseInfo[0] += [
        ("HP", object.getVariable("healthpointsStart").createValue),
        ("Contact Damage", object.getVariable("contactDamage").createValue)
    ]
    
# Minibosses
if object.assetPath.startswith(minibossRoot):
    next = object.assetPath[len(minibossRoot):]
    pos = next.find("/")
    sidebar.collapseInfo = [[]]
    if pos != -1:
        name = next[:pos]
        if name in __remap:
            name = __remap[name]
            sidebar.collapseInfo[0] += [
              ("Origin", name)
            ]
    sidebar.enabled = True
    sidebar.collapseTitles = ["Miniboss Information"]
    sidebar.collapseInfo[0] += [
        ("HP", object.getVariable("healthpointsStart").createValue),
        ("Contact Damage", object.getVariable("contactDamage").createValue)
    ]
    
# Bosses
if object.assetPath.startswith(bossRoot):
    next = object.assetPath[len(bossRoot):]
    pos = next.find("/")
    sidebar.collapseInfo = [[]]
    if pos != -1:
        name = next[:pos]
        if name in __remap:
            name = __remap[name]
            sidebar.collapseInfo[0] += [
              ("Origin", name)
            ]
    sidebar.enabled = True
    sidebar.collapseTitles = ["Boss Information"]
    sidebar.collapseInfo[0] += [
        ("HP", object.getVariable("healthpointsStart").createValue),
        ("Contact Damage", object.getVariable("contactDamage").createValue)
    ]
    
# Gimmicks
if object.assetPath.startswith(gimmickRoot):
    next = object.assetPath[len(gimmickRoot):]
    pos = next.find("/")
    sidebar.collapseInfo = [[]]
    if pos != -1:
        name = next[:pos]
        if name in __remap:
            name = __remap[name]
            sidebar.collapseInfo[0] += [
              ("Origin", name)
            ]
    sidebar.enabled = True
    sidebar.collapseTitles = ["Gimmick Information"]
    if len(sidebar.collapseInfo[0]) == 0:
        sidebar.collapseTitles = []
        sidebar.collapseInfo = []