extends Node


"""เป็นระบบเกมหลัก ใช้ update สถานะเกม ตรวจสอบ Win condition ควบคุมสิ่งที่เกิดขึ้น"""

signal _hpchanged(amount: float)
signal _player_died
signal _card_append(card: Card)
