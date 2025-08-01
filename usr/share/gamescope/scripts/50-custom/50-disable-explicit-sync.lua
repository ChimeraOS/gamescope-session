local should_disable_explicit_sync = os.getenv("GAMESCOPE_DISABLE_EXPLICIT_SYNC") == "1"
if should_disable_explicit_sync then
    local current_value = gamescope.convars.drm_debug_disable_explicit_sync.value
    info("Disable explicit sync: " .. tostring(current_value) .. " -> " .. tostring(true))
    gamescope.convars.drm_debug_disable_explicit_sync.value = true
end
