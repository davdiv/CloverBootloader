BOOTSECTORS = boot0ss boot1f32
TEXTFILES   = Description.txt Installation.txt

BOOTSECTOR_SRCS = $(addsuffix .s, $(BOOTSECTORS))
BOOTSECTOR_BINS = $(addprefix $(DESTDIR)/, $(BOOTSECTORS))

TEXTFILES_TARGET = $(addprefix $(DESTDIR)/, $(TEXTFILES))

ifeq ($(DESTDIR),)
$(error Variable DESTDIR must be defined !)
endif

ifdef NASM_PREFIX
NASM=$(NASM_PREFIX)nasm
else
NASM=nasm
endif

all: $(BOOTSECTOR_BINS) $(PBOOTSECTOR_BINS) $(TEXTFILES_TARGET)

$(BOOTSECTOR_BINS): boot0.s $(BOOTSECTOR_SRCS)
	@echo "[NASM] $(@F).s -> $@"
	@"$(NASM)" $(@F).s -o $@

$(TEXTFILES_TARGET): $(TEXTFILES)
	@cp -v $(@F) $@

clean:
	rm -f $(BOOTSECTOR_BINS) $(PBOOTSECTOR_BINS) $(TEXTFILES_TARGET) *~
