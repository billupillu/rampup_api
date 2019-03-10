# Usage

### There two APIs which are open for use 

1. Search API for text search in pdf doc
	1. curl eg: `curl -X GET -F "key=dvVNMMDYbkwiArtDjchjYJDwOSjJuaKhwhiBtvkPIPGoBiBonO" localhost:3000/home/pdf_search.json?q=Accelio`

1. Update api for updating the course and activity/module id of the Moodle 
	1. curl eg: `curl -X PUT -F "upload[course]=999" -F "upload[activity]=770" -F "key=dvVNMMDYbkwiArtDjchjYJDwOSjJuaKhwhiBtvkPIPGoBiBonO" localhost:3000/uploads/3.json`	