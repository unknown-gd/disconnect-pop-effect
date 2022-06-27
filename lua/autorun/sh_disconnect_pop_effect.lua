if game.SinglePlayer() then
    return
end

if (SERVER) then
    util.AddNetworkString( "balloon_pop_achievement" )
    hook.Add("PlayerDisconnected", "Player Disconnect Effect: POP", function( ply )
        if ply:IsListenServerHost() then return end
        local pos = ply:LocalToWorld( ply:OBBCenter() )

        local fx = EffectData()
        fx:SetOrigin( pos )
        fx:SetScale( 10 )
        fx:SetStart( ply:GetPlayerColor() * 255 )
        util.Effect( "balloon_pop", fx, true, true )

        local rf = RecipientFilter()
        rf:AddPVS( pos )
        for num, pl in ipairs( rf:GetPlayers() ) do
            net.Start( "balloon_pop_achievement" )
            net.Send( pl )
        end
    end)
end

if (CLIENT) then
    net.Receive( "balloon_pop_achievement", achievements.BalloonPopped )
end
