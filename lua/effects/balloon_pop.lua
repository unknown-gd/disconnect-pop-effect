local ParticleEmitter = ParticleEmitter
local math_random = math.random
local sound_Play = sound.Play
local math_Rand = math.Rand
local Vector = Vector
local Angle = Angle

local NumParticles = 32
local texture = "particles/balloon_bit"
local sound_path = "garrysmod/balloon_pop_cute.wav"

function EFFECT:Init( data )

	local vOffset = data:GetOrigin()
	local Color = data:GetStart()

	sound_Play( sound_path, vOffset, 90, math_random( 90, 120 ) )

	local emitter = ParticleEmitter( vOffset, true )

	for i = 0, NumParticles do

		local Pos = Vector( math_Rand( -1, 1 ), math_Rand( -1, 1 ), math_Rand( -1, 1 ) )

		local particle = emitter:Add( texture, vOffset + Pos * 8 )
		if ( particle ) then

			particle:SetVelocity( Pos * 500 )

			particle:SetLifeTime( 0 )
			particle:SetDieTime( 10 )

			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 255 )

			local Size = math_Rand( 1, 3 )
			particle:SetStartSize( Size )
			particle:SetEndSize( 0 )

			particle:SetRoll( math_Rand( 0, 360 ) )
			particle:SetRollDelta( math_Rand( -2, 2 ) )

			particle:SetAirResistance( 100 )
			particle:SetGravity( Vector( 0, 0, -300 ) )

			local RandDarkness = math_Rand( 0.8, 1.0 )
			particle:SetColor( Color.r * RandDarkness, Color.g * RandDarkness, Color.b * RandDarkness )

			particle:SetCollide( true )

			particle:SetAngleVelocity( Angle( math_Rand( -160, 160 ), math_Rand( -160, 160 ), math_Rand( -160, 160 ) ) )

			particle:SetBounce( 1 )
			particle:SetLighting( true )

		end

	end

	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
