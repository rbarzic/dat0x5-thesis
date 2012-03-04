comp:
	iverilog -o wbmaster  -c vlist_wbmaster.txt
run:
	vvp wbmaster

cr: comp run
        
check-syntax:
	iverilog -tnull -o wbmaster -c vlist_wbmaster.txt	
