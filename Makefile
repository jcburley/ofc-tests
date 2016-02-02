FRONTEND ?= ofc
FRONTEND_DEBUG ?= $(FRONTEND)-debug

TEST_DIR = .
TEST_SCRIPT = $(TEST_DIR)/test.sh
TEST_REPORT = $(TEST_DIR)/test.html
TEST_REPORT_LITE = $(TEST_DIR)/test-lite.html
TARGETS = $(sort $(wildcard $(TEST_DIR)/*.FOR))
STDERR_TARGETS = $(addsuffix .stderr, $(TARGETS))
VG_TARGETS = $(addsuffix .vg, $(TARGETS))
VGO_TARGETS = $(addsuffix .vgo, $(TARGETS))
VG_FLAGS ?= -v --leak-check=full --error-exitcode=1

# Older versions of valgrind don't support this flag.
VG_FLAGS += $(shell valgrind --help | grep errors-for-leak-kinds > /dev/null 2>&1 && echo "--errors-for-leak-kinds=all")


all : $(TEST_REPORT)


test : $(TARGETS)

$(TARGETS) : $(FRONTEND) $(FRONTEND_DEBUG)
	$(realpath $(FRONTEND)) $@
	valgrind $(VG_FLAGS) --track-origins=yes $(realpath $(FRONTEND_DEBUG)) $(patsubst %.vg, %, $@)
	valgrind $(VG_FLAGS) $(realpath $(FRONTEND)) $(patsubst %.vgo, %, $@)


test-report : $(TEST_REPORT)

test-report-lite : $(TEST_REPORT_LITE)

$(TEST_REPORT) : $(TEST_SCRIPT)
	@$(realpath $(TEST_SCRIPT)) $(realpath $(FRONTEND)) 1 1 > $(TEST_REPORT)

$(TEST_REPORT_LITE) : $(TEST_SCRIPT)
	@$(realpath $(TEST_SCRIPT)) $(realpath $(FRONTEND)) 0 0 > $(TEST_REPORT_LITE)

$(STDERR_TARGETS) : %.stderr : $(FRONTEND)
	@$(realpath $(FRONTEND)) $(patsubst %.stderr, %, $@) > $@

valgrind: $(VG_TARGETS)

valgrind-optimized: $(VGO_TARGETS)

$(VG_TARGETS) : %.vg : % $(FRONTEND_DEBUG)
	valgrind $(VG_FLAGS) --track-origins=yes $(realpath $(FRONTEND_DEBUG)) $(patsubst %.vg, %, $@) > $@ 2>&1

$(VGO_TARGETS) : %.vgo : % $(FRONTEND)
	valgrind $(VG_FLAGS) $(realpath $(FRONTEND)) $(patsubst %.vgo, %, $@) > $@ 2>&1


clean:
	rm -f $(VG_TARGETS) $(VGO_TARGETS) $(TEST_REPORT) $(TEST_REPORT_LITE)


.PHONY : all clean test test-report test-report-lite valgrind valgrind-optimized $(TARGETS)
