/*

    Title: Disconnect Effect - Balloon Pop
    GitHub: https://github.com/PrikolMen/gmod_disconnect_pop_effect
    Authors: Klen-list & PrikolMen:-b

*/

if game.SinglePlayer() then return end
local addonName = "Disconnect Effect - Balloon Pop"

if SERVER then

    local player_GetCount = player.GetCount
    local EffectData = EffectData
    local util = util
    local net = net

    util.AddNetworkString( addonName )

    hook.Add( "PlayerDisconnected", addonName, function( ply )
        if ply:IsListenServerHost() then return end
        if player_GetCount() < 2 then return end

        local pos = ply:WorldSpaceCenter()
        if not util.IsInWorld( pos ) then return end

        local fx = EffectData()
        fx:SetOrigin( pos )
        fx:SetScale( 10 )
        fx:SetStart( ply:GetPlayerColor() * 255 )
        util.Effect( "balloon_pop", fx, true, true )

        net.Start( addonName )
        net.SendPVS( pos )
    end )

end

if CLIENT then
    net.Receive( addonName, achievements.BalloonPopped )
end