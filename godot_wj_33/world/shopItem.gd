extends Node2D

var needed_money = 0
var purchase = false 

func _ready():
		$Label.text = ""
		$itemName.text = ""
		$Buy.disabled = true
		$Buy.flat = true

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if self.name == "item1":
			$Label.text = "Cost: 20 coins. \n Buy this item?"
			$itemName.text = "Full Heal"
			$Buy.disabled = false
			$Buy.flat = false
			
			needed_money = 20
					
		elif self.name == "item2":
			$Label.text = "Cost: 25 coins. \n Buy this item?"
			$itemName.text = "Speed up"
			$Buy.disabled = false
			$Buy.flat = false
			
			needed_money = 25
					
		elif self.name == "item3":
			$Label.text = "Cost: 35 coins. \n Buy this item?"
			$itemName.text = "Damage up"
			$Buy.disabled = false
			$Buy.flat = false
			
			needed_money = 35

func _on_Area2D_body_exited(body):
	if purchase == true:
		if PlayerStats.currency_count >= needed_money:
			PlayerStats.currency_count -= needed_money
			
			if needed_money == 20:
				full_heal()
				$Sprite.queue_free()
			if needed_money == 25:
				speed_up()
				$Sprite.queue_free()
			if needed_money == 35:
				dmg_up()
				$Sprite.queue_free()
				
	$Label.text = ""
	$itemName.text = ""
	$Buy.disabled = true
	$Buy.flat = true
	
func speed_up():
	PlayerStats.speed = 300
	purchase = false
	
func dmg_up():
	PlayerStats.damage = 2
	purchase = false
	
func full_heal():
	PlayerStats.health = 10
	purchase = false
	
	
	
