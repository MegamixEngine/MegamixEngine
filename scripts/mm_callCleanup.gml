/// mm_callCleanup
if (!MEMORYMANAGER_ENABLED)
{
    exit;
}
instance_create(0,0,objMemoryManager_CleanupObject);
