#!/bin/bash
weights=(20)
caches=(0)
batchs=(4)
prompts=(512)
model=facebook/opt-66b
# model=facebook/opt-175b\ --compress-weight

for (( i = 0; i < 1; i ++ )); do
	for (( j = 0; j < 1; j ++)) do
		for (( k = 0; k < 1; k ++)) do
			for (( l = 0; l < 1; l ++)) do
				echo $model
				weight=${weights[$i]}
				cache=${caches[$j]}
				batch=${batchs[$k]}
				prompt=${prompts[$l]}
				# echo $weight $((100-$weight))
				echo conf $weight $cache $batch $prompt $model | tee -a test.log
				python -m flexgen.flex_opt --model $model \
				--path _DUMMY_ --percent $weight $((100-$weight)) $cache $((100-$cache)) 100 0 \
				--gpu-batch-size $batch --pin-weight 1 \
				--num-gpu-batches 8 --prompt-len $prompt --gen-len 32 \
				| tee -a test.log
			done
		done
	done
done
