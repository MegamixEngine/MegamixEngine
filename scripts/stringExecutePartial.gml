/// stringExecutePartial(_code)
// executes the given string
// requires gigInit to have been called.
// returns false on success, or a string if there is an error.
// call gigReturnValue() to get the return value after a success.

var _code = argument0;
var gi = gig_generate(_code);//external_call(global.dll_gigGenerate, _code);

if (gig_error(gi))//external_call(global.dll_gigError, gi))
{
    var error_str = gig_what_error(gi);//external_call(global.dll_gigWhatError, gi);
    print("ERROR COMPILING CODE:");
    print(_code);
    print("ERROR IS:" + string(error_str));
    assert(false, error_str);
}

var stack, locals;
var vInstanceName, vGlobalName, vBuiltInInstanceName;
var pc = 0, sc = 0, wc = 0;
var _self = self;
var _other = other;

// size of with iterator
var withcount;
// index of with iterator
var withidx;
// with iterator list
var withv;
// with tombstone
var withtomb;
withtomb[0] = false;

// do not extend this list.
vBuiltInInstanceName[0] = "id";
vBuiltInInstanceName[1] = "object_index";

// read in instance and global names
var vInstanceNameCount = gig_variable_instance_count(gi);//external_call(global.dll_gigVariableInstanceCount, gi);
var vGlobalNameCount = gig_variable_global_count(gi);//external_call(global.dll_gigVariableGlobalCount, gi);
for (var i = 0; i < vInstanceNameCount; i++)
{
    vInstanceName[i] = gig_variable_instance_name(gi,i);//external_call(global.dll_gigVariableInstanceName, gi, i);
}
for (var i = 0; i < vGlobalNameCount; i++)
{
    vGlobalName[i] = gig_variable_global_name(gi,i);//external_call(global.dll_gigVariableGlobalName, gi, i);
}

// read in instructions
// these map from instruction address to data
var instructionCount = gig_instruction_count(gi);//external_call(global.dll_gigInstructionCount, gi);
var maxAddress = gig_instruction_address(gi,instructionCount-1);//external_call(global.dll_gigInstructionAddress, gi, instructionCount - 1);
var addressOpcode, addressAligned, addressImmediate;

// initialize arrays
addressOpcode[maxAddress] = 0;
addressAligned[maxAddress] = 0;
addressImmediate[maxAddress] = 0;

// fill arrays
for (var i = 0; i < instructionCount; i++)
{
    var address = gig_instruction_address(gi,i);//external_call(global.dll_gigInstructionAddress, gi, i);
    addressAligned[address] = true;
    addressOpcode[address] = gig_instruction_opcode(gi,i);//external_call(global.dll_gigInstructionOpcode, gi, i);
    addressImmediate[address] = gig_instruction_immediate(gi,i);//external_call(global.dll_gigInstructionImmediate, gi, i);
}

// condition flag
var fc = 0;

// execute
while (true)
{
    if (pc > maxAddress)
    {
        assert(false, "program counter exceeded bytecode section range during execution.");
    }

    if (object_index == objDestroyField)
    {
        show_debug_message("destroy_field");
    }

    // read in opcode
    var opcode = addressOpcode[pc];
    var immediate = addressImmediate[pc];

    // execute opcode
    switch(opcode)
    {
    case "ldi_false":
        stack[sc++] = false;
        break;
    case "ldi_true":
        stack[sc++] = true;
        break;
    case "ldi_undef":
    case "ldi_zero"://Note: simulates how it acted in the memleak-version of gig.
    //Is not accurate to GML. Should return 0 in Megamix 1.9.
        stack[sc++] = undefined
        break;
    case "ldi_f32":
    case "ldi_f64":
    case "ldi_s32":
    case "ldi_u64":
        stack[sc++] = real(immediate);
        break;
    case "ldi_arr"://GMS2!
        assert(false, "inline array declaration not supported yet!");
    break;
    
    case "ldi_string":
        stack[sc++] = immediate;
        break;
    case "inc":
        stack[sc - 1]++;
        break;
    case "dec":
        stack[sc - 1]--;
        break;
    case "add2":
        stack[sc - 2] = stack[sc - 2] + stack[sc - 1];
        sc--;
        break;
    case "sub2":
        stack[sc - 2] = stack[sc - 2] - stack[sc - 1];
        sc--;
        break;
    case "mult2":
        stack[sc - 2] = stack[sc - 2] * stack[sc - 1];
        sc--;
        break;
    case "fdiv2":
        stack[sc - 2] = stack[sc - 2] / stack[sc - 1];
        sc--;
        break;
    case "idiv2":
        stack[sc - 2] = stack[sc - 2] div stack[sc - 1];
        sc--;
        break;
    case "mod2":
        stack[sc - 2] = stack[sc - 2] mod stack[sc - 1];
        sc--;
        break;
    case "lsh2":
        stack[sc - 2] = stack[sc - 2] << stack[sc - 1];
        sc--;
        break;
    case "rsh2":
        stack[sc - 2] = stack[sc - 2] >> stack[sc - 1];
        sc--;
        break;
    case "lt":
        fc = stack[sc - 2] < stack[sc - 1];
        sc-=2;
        break;
    case "lte":
        fc = stack[sc - 2] <= stack[sc - 1];
        sc-=2;
        break;
    case "gt":
        fc = stack[sc - 2] > stack[sc - 1];
        sc-=2;
        break;
    case "gte":
        fc = stack[sc - 2] >= stack[sc - 1];
        sc-=2;
        break;
    case "eq":
        fc = stack[sc - 2] == stack[sc - 1];
        sc-=2;
        break;
    case "neq":
        fc = stack[sc - 2] != stack[sc - 1];
        sc-=2;
        break;
    case "bland":
        stack[sc - 2] = stack[sc - 2] && stack[sc - 1];
        sc--;
        break;
    case "blor":
        stack[sc - 2] = stack[sc - 2] || stack[sc - 1];
        sc--;
        break;
    case "blxor":
        stack[sc - 2] = stack[sc - 2] ^^ stack[sc - 1];
        sc--;
        break;
    case "band":
        stack[sc - 2] = stack[sc - 2] & stack[sc - 1];
        sc--;
        break;
    case "bor":
        stack[sc - 2] = stack[sc - 2] | stack[sc - 1];
        sc--;
        break;
    case "bxor":
        stack[sc - 2] = stack[sc - 2] ^ stack[sc - 1];
        sc--;
        break;
    case "bnot":
        stack[sc - 1] = ~(stack[sc - 1]);
        break;
    case "cond":
        if (stack[sc - 1])
        {
            fc = true;
        }
        else
        {
            fc = false;
        }
        sc--;
        break;
    case "ncond":
        if (stack[sc - 1])
        {
            fc = false;
        }
        else
        {
            fc = true;
        }
        sc--;
        break;
    case "pcond":
        stack[sc++] = fc;
        break;
    case "stl":
        locals[real(immediate)] = stack[--sc];
        break;
    case "ldl":
        stack[sc++] = locals[real(immediate)];
        break;
    case "incl":
        locals[real(immediate)]++;
        break;
    case "decl":
        locals[real(immediate)]--;
        break;
    case "sts":
        gigVariableSet(vInstanceName[real(immediate)], stack[--sc], false, _self);
        break;
    case "lds":
        stack[sc++] = gigVariableGet(vInstanceName[real(immediate)], false, _self);
        break;
    case "sto":
        {
            var val = stack[--sc];
            var _id = stack[--sc];
            if (_id == self)
            {
                _id = _self;
            }
            if (_id == other)
            {
                _id = _other;
            }
            gigVariableSet(vInstanceName[real(immediate)], val, false, _id);
        }
        break;
    case "ldo":
        {
            var val = stack[--sc];
            var _id = stack[--sc];
            if (_id == self)
            {
                _id = _self;
            }
            if (_id == other)
            {
                _id = _other;
            }
            stack[sc++] = gigVariableGet(vInstanceName[real(immediate)], false, _id);
            break;
        }
        break;
    case "stg":
        gigVariableSet(vGlobalName[real(immediate)], stack[--sc], true);
        break;
    case "ldg":
        stack[sc++] = gigVariableGet(vGlobalName[real(immediate)], true);
        break;
    case "stt":
        gigVariableSet(vBuiltInInstanceName[real(immediate)], stack[--sc], false, _self);
        break;
    case "ldt":
        stack[sc++] = gigVariableGet(vBuiltInInstanceName[real(immediate)], false, _self);
        break;
    case "stp":
        {
            var val = stack[--sc];
            var _id = stack[--sc];
            if (_id == self)
            {
                _id = _self;
            }
            if (_id == other)
            {
                _id = _other;
            }
            gigVariableSet(vBuiltInInstanceName[real(immediate)], val, false, _id);
        }
        break;
    case "ldp":
        {
            var val = stack[--sc];
            var _id = stack[--sc];
            if (_id == self)
            {
                _id = _self;
            }
            if (_id == other)
            {
                _id = _other;
            }
            stack[sc++] = gigVariableGet(vBuiltInInstanceName[real(immediate)], false, _id);
            break;
        }
        break;
    case "stsa":
        {
            var val = stack[--sc];
            var ix2 = stack[--sc];
            var ix1 = stack[--sc];
            gigVariableSet(vInstanceName[real(immediate)], val, false, _self, ix1, ix2);
        }
        break;
    case "ldsa":
        {
            var ix2 = stack[--sc];
            var ix1 = stack[--sc];
            stack[sc++] = gigVariableGet(vInstanceName[real(immediate)], false, _self, ix1, ix2);
        }
        break;
    case "stoa":
        {
            var val = stack[--sc];
            var _id = stack[--sc];
            if (_id == self)
            {
                _id = _self;
            }
            if (_id == other)
            {
                _id = _other;
            }
            var ix2 = stack[--sc];
            var ix1 = stack[--sc];
            gigVariableSet(vInstanceName[real(immediate)], val, false, _id, ix1, ix2);
        }
        break;
    case "ldoa":
        {
            var val = stack[--sc];
            var _id = stack[--sc];
            if (_id == self)
            {
                _id = _self;
            }
            if (_id == other)
            {
                _id = _other;
            }
            var ix2 = stack[--sc];
            var ix1 = stack[--sc];
            stack[sc++] = gigVariableGet(vInstanceName[real(immediate)], false, _id, ix1, ix2);
            break;
        }
        break;
    case "stga":
        {
            var val = stack[--sc];
            var ix2 = stack[--sc];
            var ix1 = stack[--sc];
            gigVariableSet(vGlobalName[real(immediate)], val, true, ix1, ix2);
            break;
        }
    case "ldga":
        {
            var ix2 = stack[--sc];
            var ix1 = stack[--sc];
            stack[sc++] = gigVariableGet(vGlobalName[real(immediate)], true, ix1, ix2);
            break;
        }
    case "pop":
        sc--;
        break;
    case "dup":
        sc++;
        stack[sc] = stack[sc - 1];
        break;
    case "dup2":
        sc += 2;
        stack[sc - 2] = stack[sc - 4];
        stack[sc - 1] = stack[sc - 3];
        break;
    case "dup3":
        sc += 3;
        stack[sc - 3] = stack[sc - 6];
        stack[sc - 2] = stack[sc - 5];
        stack[sc - 1] = stack[sc - 4];
        break;
    case "dupn":
        {
            var n = floor(real(immediate));
            sc += n;
            for (var i = 1; i <= n; i++)
            {
                stack[sc - i] = stack[sc - i - n];
            }
        }
        break;
    case "nat":
        {
            // parse immediate function description of form fnname:argc
            var fn = "";
            var argc = 0;
            for (var i = 1; i <= string_length(immediate); i++)
            {
                var c = string_char_at(immediate, i);
                if (c == ':')
                {
                    var argcs = string_copy(immediate, i + 1, string_length(immediate) - i);
                    argc = floor(real(argcs));
                    break;
                }
                fn += c;
            }

            // pass in arguments from the stack
            var argv;
            argv[0] = 0;
            for (var i = 0; i < argc; i++)
            {
                argv[i] = stack[sc - argc + i];
            }
            sc -= argc;

            // execute function
            global.dll_gigExecutionError = false;
            var perf = false;
            with (_self)
            {
                perf = true;
                stack[sc++] = gigFunction(fn, argc, argv);
            }
            if (!perf)
            {
                stack[sc++] = gigFunction(fn, argc, argv);
            }
            if (global.dll_gigExecutionError == 1)
            {
                assert(false, "The function '" + fn  + "'could not be executed, as it is not a user-defined script nor is it listed in the script gigFunction. Please consider adding it to the script gigFunction if it is a built-in script.");
            }
            if (global.dll_gigExecutionError == 2)
            {
                assert(false, "The function '" + fn  + "' was invoked with " + string(argc) + " arguments, which is too many for the interpreter to handle.");
            }
        }
        break;
    case "wti":
        {
            // find an iterator index
            var found = false;
            var wi = wc++;//0;
            /*for (var i = 0; i < wc; i++)
            {
                if (!withtomb[i])
                {
                    found = true;
                    wi = i;
                    break;
                }
            }
            if (!found)
            {
                wi = wc++;
            }
            We aren't freeing up these tombstones to begin with, so just go further ahead.
            They free themselves at the end of the statement anyways.
            */

            // construct iterator
            var wcond = stack[--sc];
            withidx[wi] = 0;
            withcount[wi] = 0;
            withtomb[wi] = false;
            with (wcond)
            {
                withv[wi, withcount[wi]++] = id;
            }

            stack[sc++] = _other;
            stack[sc++] = _self;

            // push current id onto stack
            stack[sc++] = wi;
        }
        break;
    case "wty":
        {
            // retrive iterator index
            var wi = stack[sc - 1];
            var valid = true;

            if (wi >= wc)
            {
                valid = false;
            }
            else if (withtomb[wi])
            {
                valid = false;
            }
            if (!valid)
            {
                gig_free(gi);
                return "yield from invalid with-iterator.";
            }
            if (withidx[wi] >= withcount[wi])
            {
                // iterator elapsed. Free iterator, restore self.
                withtomb[wi] = true;

                // pop iterator
                --sc;

                // pop self and other
                _self = stack[--sc];
                _other = stack[--sc];

                fc = true;
            }
            else
            {
                // set self
                _self = withv[wi, withidx[wi]++];

                fc = false;
            }
        }
        break;
    case "wtd":
        {
            var wi = stack[--sc];
            _self = stack[--sc];
            _other = stack[--sc];
            withtomb[wi] = true;
        }
        break;
    case "jmp":
        // subtract 1 to account for pc advancement
        pc = floor(real(immediate)) - 1;
        break;
    case "bcond":
        if (fc)
        {
            // subtract 1 to account for pc advancement
            pc = floor(real(immediate)) - 1;
        }
        break;
    case "ret":
        if (sc != 1)
            assert(false, "Bytecode execution finished with " + string(sc) + " values on stack.")
        global.dll_gigReturnValue = stack[0];
        gig_free(gi);
        return false;
    case "eof":
        assert(false, "bytecode eof reached -- unexpected.");
    case "nop":
        break;
    case "all":
        // can be safely ignored.
        break;
    case "ldi_self"://GMS2!
        assert(false, "Self reference not supported yet!");//This error message may not be accurate?
    break;
    case "ldi_other"://GMS2!
        assert(false, "Other reference not supported yet!");//This error message may not be accurate?
    break;
    case "ldi_fn"://GMS2!
    case "calls"://GMS2!
        assert(false, "Functions not supported yet! " + opcode);
    break;
    case "ldi_struct"://GMS2!
    case "tstruct"://GMS2!
        assert(false, "Structs not supported yet! " + opcode);
    break;
    case "okg"://GMS2!
        assert(false, "Static variables not supported yet! " + opcode);
    break;
    case "stlax"://GMS2!
    case "ldlax"://GMS2!
        assert(false, "Inline array declaration not supported yet! " + opcode);
    
    break;
    case "stoax"://GMS2!
    case "ldoax"://GMS2!
        assert(false, "Nested array access not supported yet! " + opcode);
    break;
    case "ldla":
        assert(false, "Local arrays not supported yet! "+ opcode);
    break;
    case "stpa":
    case "ldpa":
    case "pshl":
    case "popl":
    case "pshe":
    case "pope":
    case "call":
        assert(false, "opcode " + opcode + " was expected to not be generated, but was encountered anyway.")
    case "sfx":
    case "ufx":
        assert(false, "write-no-copy array accessor not supported (though it could be in the future.)");
    case "stla":
    default:
        assert(false, "opcode not implemented: " + opcode + " at address " + string(pc));
    }

    do
    {
        pc += 1;
    } until (addressAligned[pc]);
}
gig_free(gi);
return false;
