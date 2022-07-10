if game.SinglePlayer() then return end

/*

    Title: The Balloon Pop Player Disconnect Effect
    GitHub: https://github.com/PrikolMen/gmod_disconnect_pop_effect
    Authors: Klen-list & PrikolMen:-b

*/

if (SERVER) then

    util.AddNetworkString( "balloon_pop_achievement" )

    local player_GetCount = player.GetCount
    local RecipientFilter = RecipientFilter
    local util_IsInWorld = util.IsInWorld
    local util_Effect = util.Effect
    local EffectData = EffectData
    local net_Start = net.Start
    local net_Send = net.Send
    local ipairs = ipairs

    hook.Add("PlayerDisconnected", "Player Disconnect Effect: POP", function( ply )
        if ply:IsListenServerHost() then return end
        if (player_GetCount() < 2) then return end

        local pos = ply:LocalToWorld( ply:OBBCenter() )
        if util_IsInWorld( pos ) then
            local fx = EffectData()
            fx:SetOrigin( pos )
            fx:SetScale( 10 )
            fx:SetStart( ply:GetPlayerColor() * 255 )
            util_Effect( "balloon_pop", fx, true, true )

            local rf = RecipientFilter()
            rf:AddPVS( pos )
            for num, pl in ipairs( rf:GetPlayers() ) do
                net_Start( "balloon_pop_achievement" )
                net_Send( pl )
            end
        end
    end)

end

if (CLIENT) then
    net.Receive( "balloon_pop_achievement", achievements.BalloonPopped )
end
