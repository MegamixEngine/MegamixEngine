// spawnTextBoxSingleString(name, name color, text);

_name = argument0;
_name_col = argument1;
_text = argument2;

var newline = "
";

// initialize variables
mytext = _text + ' ';
subtext = mytext; // subtext is just the text we're parsing, but is run through and deleted without stuff being saved to figure out line length. mytext is then used to actually get the text and put it into the arrays

for (i = 1; i <= 12; i += 1)
{
    txt[i] = -1;
    t[i] = "";
}

linelength = 25 + 1; // despite the number in the textbox object itself, it actually works at a value that's one larger

space = 0;
prespace = 0;
effectSpace = 0;

i = 1; // index of the text array to be directly put into spawnTextBox()
z = 0; // counts up lines

txtEffectMove = "";
txtEffectCol = "";

timeOut = 0;

// Separate Text into fine bits ( Please for the love of god comment your string parsing code next time. Figuring out how this works was a pain. -Entity1037 )
while (string_length(mytext) > 0)
{
    // run through each word and see which word ends up going over the line length
    s = string_pos(' ', subtext); // get position of next space
    space += s; // count how far across we are into the line
    
    // newline character
    newLinePos = string_pos("#", subtext);
    if (newLinePos > 0 && (s <= 0 || newLinePos < s))
    {
        space = linelength * 2;
        prespace += newLinePos;
    }
    
    // identify text effects and figure out how much space they take up
    
    /* e = string_copy(subtext, 1, s);
    newLinePos = string_pos("#", e);
    
    if (newLinePos > 0)
    {
        space = linelength * 2; //trigger new line
        prespace -= string_length(e) - newLinePos; //set the end position of what to put into the line at the line break
    }*/
    
    // color effects
    e = string_copy(subtext, 1, s);
    ep = string_pos("/C", e);
    
    if (ep > 0 && (newLinePos <= 0
        || ep < newLinePos)) // only count effects if before new line break
    {
        // account for all of the text effects in the word, only saving the last one
        while (string_length(e) > 0 && ep > 0)
        {
            ep = string_pos("/C",
                e); // it always gives the position of the first instance
            
            // no more possible commands
            if (ep <= 0)
            {
                break;
            }
            
            c = string_copy(e, ep + 2, 1);
            if (c == "0" || c == "1" || c == "2")
            {
                txtEffectCol = string_copy(e, ep, 3);
                effectSpace += 3;
                
                e = string_delete(e, ep, 3);
            }
            else
            {
                // not a command
                e = string_delete(e, ep, 2);
            }
        }
    }
    
    // movement effects
    e = string_copy(subtext, 1, s);
    ep = string_pos("/", e);
    
    if (ep > 0 && (newLinePos <= 0
        || ep < newLinePos)) // only count effects if before new line break
    {
        // account for all of the text effects in the word, only saving the last one
        while (string_length(e) > 0 && ep > 0)
        {
            ep = string_pos("/",
                e); // it always gives the position of the first instance
            
            // no more possible commands
            if (ep <= 0)
            {
                break;
            }
            
            c = string_copy(e, ep + 1, 1);
            if (c == "0" || c == "1" || c == "2")
            {
                txtEffectMove = string_copy(e, ep, 2);
                effectSpace += 2;
                
                e = string_delete(e, ep, 2);
            }
            else
            {
                // not a command
                e = string_delete(e, ep, 1); // remove from the stuff to check
            }
        }
    }
    
    
    
    subtext = string_delete(subtext, 1,
        s); // remove the word form the text to check
    
    // checking newLinePos because if there is a line break command and this is also true, it'll overwrite the line break task
    if (newLinePos <= 0 && string_length(mytext) - effectSpace - 1
        <= linelength) // if the remaining text fits into a single line
    {
        space = linelength
            * 2; // trigger adding the rest of the text to the current line
        prespace = string_length(
            mytext); // set the end of the line to save as the end of the entire text
    }
    
    
    
    // if the line is finished, add to the array of lines for the current page
    if (space - effectSpace - 1
        > linelength) //- 1 so we don't count the space or line break as part of the word
    {
        t[z] = string_copy(mytext, 1 - 1,
            prespace - 1); // cut off the space / line break
        
        // if (space - effectSpace - 1 != linelength) //if maxed out the line, then don't do this because it'll wrap anyway
        //{
        t[z] += "#"; // add the line break for the next line
        
        //}
        
        // fill the remaining, unfilled space in the line with spaces so
        /* while (string_length(t[z]) < linelength)
        {
            t[z] += ' ';
        }*/
        
        mytext = string_delete(mytext, 1,
            prespace); // delete the line that was just saved from the remaining text
        subtext = mytext;
        space = 0;
        effectSpace = 0;
        prespace = 0;
        z += 1; // count up a line
        
        // add lines of the current page to the array to be put into the textbox
        if (z == 5 || string_length(mytext) <= 0)
        {
            if (is_string(txt[i]))
            {
                txt[i] += t[0] + t[1] + t[2] + t[3] + t[4];
            }
            else
            {
                txt[i] = t[0] + t[1] + t[2] + t[3] + t[4];
            }
            
            
            if (i == 12)
            {
                break;
            } // if reached max textbox pages, then don't do any more pages
            
            i += 1;
            
            // clear the current lines array
            for (z = 0; z < 5; z += 1)
            {
                t[z] = '';
            }
            
            // reset line counter
            z = 0;
            
            // carry over previous text effect if there's another page
            if (string_length(mytext) > 0)
            {
                if (txtEffectMove != "" && txtEffectMove != "/0")
                {
                    txt[i] = txtEffectMove;
                }
                
                if (txtEffectCol != "" && txtEffectCol != "/C0")
                {
                    if (is_string(txt[i]))
                    {
                        txt[i] += txtEffectCol;
                    }
                    else
                    {
                        txt[i] = txtEffectCol;
                    }
                }
            }
        }
    }
    
    prespace = space; // save the position of the end of the last word
    
    timeOut += 1;
    if (timeOut >= 1000)
    {
        show_error(
            "An infinite loop occured in the text wrap parsing! Here's the status of the variables."
            + newline + space + ": " + string(space)
            + newline + "prespace: " + string(prespace)
            + newline + "subtext: " + string(subtext)
            + newline + "mytext: " + string(mytext)
            + newline + "i: " + string(i) + newline + "z: " + string(z)
            + newline + "t[i]: " + string(t[i]) + newline + "txt[i]: "
            + string(txt[i]) + newline + "s: " + string(s), false);
        
        break;
    }
}

if (timeOut < 1000)
{
    spawnTextBox(0, 0, _name, _name_col, txt[1], txt[2], txt[3], txt[4],
        txt[5], txt[6], txt[7], txt[8], txt[9], txt[10], txt[11], txt[12]);
}
