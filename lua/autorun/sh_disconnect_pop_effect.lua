if game.SinglePlayer() then return end
local addonName = 'Disconnect Effect - Balloon Pop'

/*

    Title: Disconnect Effect - Balloon Pop
    GitHub: https://github.com/PrikolMen/gmod_disconnect_pop_effect
    Authors: Klen-list & PrikolMen:-b

*/

if (SERVER) then

    util.AddNetworkString( addonName )

    local player_GetCount = player.GetCount
    local util_IsInWorld = util.IsInWorld
    local util_Effect = util.Effect
    local net_SendPVS = net.SendPVS
    local EffectData = EffectData
    local net_Start = net.Start

    hook.Add('PlayerDisconnected', addonName, function( ply )
        if ply:IsListenServerHost() then return end
        if (player_GetCount() < 2) then return end

        local pos = ply:LocalToWorld( ply:OBBCenter() )
        if util_IsInWorld( pos ) then
            local fx = EffectData()
            fx:SetOrigin( pos )
            fx:SetScale( 10 )
            fx:SetStart( ply:GetPlayerColor() * 255 )
            util_Effect( 'balloon_pop', fx, true, true )
            net_Start( addonName )
            net_SendPVS( pos )
        end
    end)

end

if (CLIENT) then
    net.Receive( addonName, achievements.BalloonPopped )
end
