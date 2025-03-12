/// shader_set_safe(shader)
///Sets a shader only if that shader could be compiled on startup. Otherwise, it simply does nothing.
if (shader_is_compiled(argument[0]))
{
    shader_set(argument[0]);
}
