#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <unistd.h> 
#include <stdint.h>

#define HINTS                                                                  \
  "### Sin Table Generator ###\nUsage:\n\t./sin_table_gen -P <Points per Period> -N <DAC bit width (32 bit max)> \n"

int main(int argc, char **argv)
{
    FILE *fp = NULL;

    int32_t c;

    uint32_t P = 0;
    uint32_t N = 0;

    uint32_t p = 0;

    uint32_t code = 0;

    double phase_const = 0.0;
    double phase = 0.0;
    double scale = 0.0;

    if (argc < 3) {
        fprintf(stderr, HINTS);
        return -1;
    } else {

        while ( (c = getopt(argc, argv, "P:N:")) != -1) {
        
            switch (c) {

                case 'P':
                    P = atoi(optarg);
                    phase_const = 2.0 * M_PI / (double)P;
                    break;

                case 'N':
                    N = atoi(optarg);
                    if (N > 32) {
                        fprintf(stderr, "Max val of arg -N is 32 bit\n");
                        fprintf(stderr, HINTS);
                        return -1;
                    }
                    scale = ( (double)( (1l << N) - 1l) ) / 2.0;
                    break;

                case '?':
                    fprintf(stderr, HINTS);
                    return -1;

                default:
                    fprintf(stderr, "ERR: Failed to process arguments\n");
                    return -1;
            }
        }
    }

    fp = fopen("sintable.hex", "w");

    if (NULL == fp) {
        fprintf(stderr, "Unable create sintable.hex file");
        return -1;
    }

    for (p = 0; p < P; p++) {
        phase = phase_const * (double)p;
        code = floor(scale * (sin(phase) + 1.0) + 0.5);
        //printf("code[%d] = %x;\n", p, code );
        //printf("code[%d] = %f;\n", p, sin(phase) );
        fprintf(fp, "%x\n", code);
    }

    fclose(fp);
    
    return 0;
}
