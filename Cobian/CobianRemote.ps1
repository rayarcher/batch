
(gc 'C:\Program Files (x86)\Cobian Backup 11\Settings\cbEngine.ini').replace("Use remote manager=false", "Use remote manager=true") | Out-File 'C:\Program Files (x86)\Cobian Backup 11\Settings\cbEngine.ini'

(gc 'C:\Program Files (x86)\Cobian Backup 11\Settings\cbEngine.ini').replace("Manager host=127.0.0.1", "Manager host=172.16.0.242") | Out-File 'C:\Program Files (x86)\Cobian Backup 11\Settings\cbEngine.ini'

(gc 'C:\Program Files (x86)\Cobian Backup 11\Settings\cbEngine.ini').replace("Manager password=cABiAH4AfwB+AGAAegB5AHkAaAA4AHwACQADAA8AcwB5AHUAaQAdAA4AcgB4AHIAYAAEAAQAAABsAB0AcQAJAH0AdwBgACwAFAABAH4ABAB+ABMAZQB5AG0AcAAOADoAfwAqAA==", "Manager password=eQBlAHwAfQBpAHoAfgB1AGIAegAjAHIADAACAAMAcgB6AHUAcwAdAAQAcgBzAHIAfQAEAAAAAABvAB0AbgAJAHkABQBgAAEAGQAtAGEAAQB/AAIAcwB8AH8AYAAJAD4AcgAyAAYAPAA=") | Out-File 'C:\Program Files (x86)\Cobian Backup 11\Settings\cbEngine.ini'

net stop CobianBackup11

net start CobianBackup11
