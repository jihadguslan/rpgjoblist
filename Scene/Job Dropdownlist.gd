extends Control

@onready var jobname = $jobname
@onready var description = $description
@onready var skill1 = $HBoxContainer/skill1
@onready var skill2 = $HBoxContainer/skill2
@onready var skill3 = $HBoxContainer/skill3
@onready var dropdown = $Dropdown

var data_pekerjaan = {}

func _ready():
	var file = "res://resource/class.csv"
	var file_data = FileAccess.open(file,FileAccess.READ)
	
	var isi = file_data.get_as_text()
	file_data.close()
	
	var baris = isi.split("\n")
	for line in baris:
		var kolom = line.split(";")
		if len(kolom) >= 4:
			var id = kolom[0]
			var pekerjaan = kolom[1]
			var deskripsi = kolom[2]
			var keterampilan = kolom[3]
			data_pekerjaan[pekerjaan] = {"ID": id, "JOBNAME":pekerjaan, "DESCRIPTION": deskripsi, "SKILL": keterampilan.split(",")}
		print(kolom)

	dropdown.clear()
	for pekerjaan in data_pekerjaan.keys():
		dropdown.add_item(pekerjaan)

func _on_dropdown_item_selected(index):
	var pekerjaan_terpilih = dropdown.get_item_text(index)
	if pekerjaan_terpilih in data_pekerjaan:
		if data_pekerjaan[pekerjaan_terpilih]["JOBNAME"] != ""  :
			if data_pekerjaan[pekerjaan_terpilih]["JOBNAME"] != "JOBNAME":
				jobname.text = "Jobname : " + data_pekerjaan[pekerjaan_terpilih]["JOBNAME"]
				description.text = "Description : " + data_pekerjaan[pekerjaan_terpilih]["DESCRIPTION"]
				skill1.text = data_pekerjaan[pekerjaan_terpilih]["SKILL"][0]
				skill2.text = data_pekerjaan[pekerjaan_terpilih]["SKILL"][1]
				skill3.text = data_pekerjaan[pekerjaan_terpilih]["SKILL"][2]
			else :
				clear_op()
		else:
			clear_op()

func clear_op():
	jobname.text = "Jobname : "
	description.text = "Description : "
	skill1.text = ""
	skill2.text = ""
	skill3.text = ""
