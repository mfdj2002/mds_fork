deepspeed --hostfile /users/jf3516/hostfile.txt  /users/jf3516/Megatron-DeepSpeed/examples_deepspeed/rebase/../../pretrain_gpt.py --override-opt_param-scheduler --adam-beta1 0.9 --adam-beta2 0.95 --tensor-model-parallel-size 1 --init-method-std 0.02 --lr-decay-tokens 300000000000 --lr-warmup-tokens 3000000000 --micro-batch-size 4 --exit-duration-in-mins 30000000 --global-batch-size 8 --num-layers 12 --hidden-size 768 --num-attention-heads 12 --seq-length 2048 --max-position-embeddings 2048 --train-tokens 300000000000 --train-samples 292968750 --lr 6.0e-4 --min-lr 1.0e-6 --lr-decay-style cosine --split 949,50,1 --log-interval 10 --eval-interval 100 --eval-iters 10 --save-interval 100 --weight-decay 0.1 --clip-grad 1.0 --hysteresis 2 --num-workers 0 --seed 1234 --load /mnt/training_out/checkpoint/gpt_0.125B_tok300B_lr6.0e-4_min1.0e-6_w3000M_d300B_cosine_gbs8_mbs4_g1_seed1234_rebase --save /mnt/training_out/checkpoint/gpt_0.125B_tok300B_lr6.0e-4_min1.0e-6_w3000M_d300B_cosine_gbs8_mbs4_g1_seed1234_rebase --no-async-tensor-model-parallel-allreduce --checkpoint-activations --vocab-file gpt2-vocab.json --merge-file gpt2-merges.txt --data-path /users/jf3516/Megatron-DeepSpeed/examples_deepspeed/rebase/dataset/pile_gpt_train_text_document --data-impl mmap --deepspeed --deepspeed_config ds_config_gbs8_mbs4_log10_zero0.json --zero-stage 0 --pipeline-model-parallel-size 1 --no-pipeline-parallel --deepspeed-activation-checkpointing --data-cache-path /mnt/cache


#todo: automate adding hostfile address