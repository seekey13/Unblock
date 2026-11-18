--[[
Unblock
When a command is blocked by "You cannot use that command while invisible.",
removes Invisible, Hide and Camouflage (requires the debuff addon by atom0s).
When a command is blocked by "You cannot use that command while mounted.",
dismounts (only if the Mounted status is actually present).
The blocked command is not retried; issue it again.
Copyright (c) 2025 Seekey
https://github.com/seekey13/Unblock

This addon is designed for Ashita v4.
]]

addon.name      = 'Unblock';
addon.author    = 'Seekey';
addon.version   = '0.2';
addon.desc      = 'Automatically removes invisible status or dismounts when blocked by them';
addon.link      = 'https://github.com/seekey13/Unblock';

require('common');

local INVIS_BUFFS = {
    {id = 69, name = 'Invisible'},
    {id = 76, name = 'Hide'},
    {id = 77, name = 'Camouflage'}
};

local MOUNTED_BUFF = 252;

-- Buff array is fixed at 32 slots; 255/0 are empty markers
local function is_mounted()
    local player = AshitaCore:GetMemoryManager():GetPlayer();
    local buffs = player and player:GetBuffs();
    if not buffs then return false; end
    for i = 1, 32 do
        if buffs[i] == MOUNTED_BUFF then return true; end
    end
    return false;
end

-- Event: Incoming text (chat messages)
ashita.events.register('text_in', 'text_in_cb', function (e)
    local chatMgr = AshitaCore:GetChatManager();

    -- The mounted block message may not arrive in mode 121, so match it in any mode.
    -- The buff check keeps a player typing the phrase in chat from dismounting us.
    if string.find(e.message, 'You cannot use that command while mounted', 1, true) then
        if is_mounted() then
            chatMgr:QueueCommand(1, '/dismount');
        end
        return;
    end

    -- Only check messages in channel mode 121 (system text)
    local redcol = e.mode % 256;
    if redcol == 121 then
        -- Check if the message contains the invisibility block message
        if string.find(e.message, 'You cannot use that command while invisible.', 1, true) then
            -- Issue the command to remove invisible buff
            for _, buff in ipairs(INVIS_BUFFS) do
                chatMgr:QueueCommand(1, string.format('/debuff %d', buff.id));
            end
        end
    end
end);