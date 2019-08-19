#cls
#Set-ExecutionPolicy -Bypass
$countdown = 100 # in seconds
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

#~~< Messagebox >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Messagebox = New-Object System.Windows.Forms.Form
$Messagebox.ClientSize = "380, 200"
$Messagebox.FormBorderStyle = "FixedToolWindow"
$Messagebox.StartPosition = 1  # center sceen
#~~< Button: No >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonNo = New-Object System.Windows.Forms.Button
$ButtonNo.Location = "185, 115"
$ButtonNo.Size = "75, 23"
$ButtonNo.Text = "Nein"
$ButtonNo.UseVisualStyleBackColor = $true
$Messagebox.CancelButton = $ButtonNo
#~~< Label: CountDownText >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$LabelCountDownText = New-Object System.Windows.Forms.Label
$LabelCountDownText.Font =  "Segoe UI, 8pt"
$LabelCountDownText.Location = "37, 70"
$LabelCountDownText.Size = "223, 40"
$LabelCountDownText.TabIndex = 3
$LabelCountDownText.Text = "Der PC fährt automatisch in $countdown sekunden herunter..."
#~~< Button:Yes >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ButtonYes = New-Object System.Windows.Forms.Button
$ButtonYes.Location = "67, 115"
$ButtonYes.Size = "75, 23"
$ButtonYes.Text = "Ja"
$ButtonYes.UseVisualStyleBackColor = $true
#~~< Label: MainMessage >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$LabelMainMessage = New-Object System.Windows.Forms.Label
$LabelMainMessage.Font =  "Segoe UI, 11pt"
$LabelMainMessage.Location = "34, 31"
$LabelMainMessage.Size = "350, 28"
$LabelMainMessage.Text = "Soll der PC heruntergefahren werden?"
$Messagebox.Controls.Add($LabelCountDownText)
$Messagebox.Controls.Add($ButtonNo)
$Messagebox.Controls.Add($ButtonYes)
$Messagebox.Controls.Add($LabelMainMessage)
#~~< Timer >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Timer1 = New-Object System.Windows.Forms.Timer
$Timer1.Interval = 1000  # in miliseconds
#~~< Events >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Messagebox.add_shown({  $Timer1.Start() })
$Messagebox.add_Closing({ FNcleanUp })
$ButtonNo.add_click({ FNcleanUP })
$ButtonYes.add_click({ FNcleanUp ; FNshutDown })
$Timer1.add_Tick({ 
		$script:countdown --
		$LabelCountDownText.Text = "Der PC fährt automatisch in $countdown sekunden herunter..."
		if ($countdown -le 0) {
			FNcleanUp
			FNshutDown
		}
	})
	
#~~< Functions >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
Function FNcleanUp {
	$Messagebox.dispose()
	$Timer1.Dispose()
}	

Function FNshutDown { 
	shutdown /s /f /t 0
}
#~~< Run the whole thing >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[System.Windows.Forms.Application]::Run($Messagebox)
