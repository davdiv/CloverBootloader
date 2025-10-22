

Clover:
	@echo "Building Clover..."
	@make -C BaseTools/Source/C
	@./ebuild.sh -gcc131 -D LESS_DEBUG -D NO_GRUB_DRIVERS_EMBEDDED
	@echo [BUILD] "Clover " $Version.h

clean:
	@./ebuild.sh -gcc131 -clean >/dev/null
	@rm -rf build *~
	@echo [CLEAN] 

.PHONY: Clover clean
