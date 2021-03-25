#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct {
  char *phrase;
  char *derivation_path;
  char *spending_key;
  char *viewing_key;
  char *address;
} CKeys;

bool check_address(char *address);

uint64_t get_balance(char *database_path);

CKeys init_account(char *database_path);

bool initialize(char *database_path);

void send_tx(char *database_path,
             char *address,
             uint64_t amount,
             char *spending_key,
             const char *spend_params,
             uintptr_t len_spend_params,
             const char *output_params,
             uintptr_t len_output_params);

uint64_t sync(char *database_path, uint32_t max_blocks);
