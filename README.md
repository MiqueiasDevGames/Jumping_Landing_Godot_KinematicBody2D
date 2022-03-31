# Jumping_Landing_Godot_KinematicBody2D
Script for jumping and landing animatedsprite godot engine

In Men.gd I save the y position of the previous frame in yframe and compare it with the current one, if current position.y < yframe means the player is jumping, now if position.y > yframe it means our player is landing. . works even for when the player is walking on the map and going downhill.
