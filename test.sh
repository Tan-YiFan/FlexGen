#!/bin/bash
weights=(20 30 50)
caches=(50 60 100)
batchs=(4 8 16)
prompts=(512 1024)

for (( i = 0; i < 3; i ++ )); do
	for (( j = 0; j < 3; j ++)) do
		for (( k = 0; k < 3; k ++)) do
			for (( l = 0; l < 2; l ++)) do
				weight=${weights[$i]}
				cache=${caches[$i]}
				batch=${batchs[$i]}
				prompt=${prompts[$i]}
				# echo $weight $((100-$weight))
				echo $weight $cache $batch $prompt | tee -a test.log
				python -m flexgen.flex_opt --model facebook/opt-66b \
				--path _DUMMY_ --percent $weight $((100-$weight)) $cache $((100-$cache)) 100 0 \
				--gpu-batch-size 4 --pin-weight 1 \
				--num-gpu-batches $batchs --prompt-len $prompt --gen-len 32 \
				| tee -a test.log
			done
		done
	done
done
