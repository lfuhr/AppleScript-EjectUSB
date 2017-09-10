on open speicher
	repeat with einspeicher in speicher
		set einspeicher to POSIX path of einspeicher
		set sicherungsplatte to false
		try
			do shell script "cd '" & einspeicher & "Backups.backupdb'"
			set sicherungsplatte to true
		end try
		try
			do shell script "cd '" & einspeicher & "iPod_Control'"
			set sicherungsplatte to true
		end try
		set einspeicher to quoted form of einspeicher
		with timeout of 450 seconds

			try
				if (einspeicher = "'/'") or (sicherungsplatte = true) then
					display dialog "Du kannst nicht die Hauptpartition, die TimeMachine-Partition oder einen iPod bearbeiten. Wirf diese mittels des Papierkorbs aus." buttons {"Ok"} default button 1
				else
					do shell script "find " & einspeicher & " -name \\.DS_Store -exec rm -rf {} \\; ; dot_clean " & einspeicher & "; rm -rf " & einspeicher & ".Trashes ; rm -rf " & einspeicher & ".Spotlight-V100 ; rm -rf " & einspeicher & ".HPIMAGE.VFS ; rm -rf " & einspeicher & ".TemporaryItems; rm -rf " & einspeicher & ".apdisk; rm -rf " & einspeicher & ".fseventsd ; diskutil unmount " & einspeicher
				end if
			on error fehler
				with timeout of 650 seconds
					display dialog "Es ist ein Fehler beim Bearbeiten des Volumes " & einspeicher & " aufgetreten:" & return & return & fehler & return & return & "Evtl. noch einmal probieren…" buttons {"Ok"} default button 1 giving up after 600
				end timeout
			end try
		end timeout
	end repeat
	beep 2
end open

on run
	display dialog "Dieses Skript löscht von USB Speichern Mac-spezifischen Dateien. Einfach ein oder mehrere Volume-Icons auf das App-Icon ziehen, diese werden nacheinander abgearbeitet." buttons {"Ok"} default button 1 giving up after 600
end run