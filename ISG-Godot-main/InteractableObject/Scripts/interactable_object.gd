extends StaticBody2D

@onready var message = $Label 

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Print to console to verify what is actually hitting the zone
	print("Something entered: ", body.name)
	
	# Match this name to your character's actual node name
	if body.name == "CharacterBody2D": 
		message.show()
		print("Showing message!")
		
		# --- NEW CODE START ---
		# Create a 3-second timer and wait for it to finish
		await get_tree().create_timer(3.0).timeout
		
		# Hide the message after the wait
		message.hide()
		# --- NEW CODE END ---

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		message.hide()
