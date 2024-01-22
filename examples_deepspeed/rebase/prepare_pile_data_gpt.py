import sys
import time
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), os.path.pardir, os.path.pardir)))
from megatron.data import indexed_dataset

# def pile_merge(output_path):
def pile_merge():
    start = time.time()
    num_chunks = 1  # Adjust this to the number of chunks you have
    vocab_size = 50257  # Update this to the vocab size of your GPT model

    # for i in range(num_chunks):
    # output_prefix = f"{output_path}pile_gpt_train"
    output_prefix = "./dataset/enron_email"
    assert os.path.exists(f"{output_prefix}_text_sentence.idx")
    assert os.path.exists(f"{output_prefix}_text_sentence.bin")

    builder = indexed_dataset.make_builder(
        f"{output_prefix}_text_sentence.bin", impl="mmap",
        vocab_size=vocab_size)

    # for i in range(num_chunks):
    chunk_file = f"{output_prefix}_text_sentence"
    print(f"Merging file {chunk_file}")
    builder.merge_file_(chunk_file)

    print("Finalizing merged file ...")
    builder.finalize(f"{output_prefix}_text_sentence.idx")
    print(f"Finished merging in {time.time() - start} sec")

def pile_preprocess(file_path, output_path, merge_file, vocab_file, num_workers):
    json_file_path = f"{file_path}.jsonl"
    output_prefix = f"{output_path}pile_gpt_train"
    if not os.path.exists(f"{output_prefix}_text_sentence.idx"):
        start = time.time()
        cmd = f"python ../../tools/preprocess_data.py \
                --input {json_file_path} \
                --output-prefix {output_prefix} \
                --merge-file {merge_file} \
                --vocab-file {vocab_file} \
                --dataset-impl mmap \
                --tokenizer-type GPT2BPETokenizer \
                --workers {num_workers} "
        if os.system(cmd) == 0: # Success
            os.remove(json_file_path)
        else:
            print(f"Error: chunk preprocessing got error, delete \
                    incomplete output. If MemoryError appeared, please retry \
                    with num_workers smaller than {num_workers}.")
            if os.path.exists(f"{output_prefix}_text_sentence.idx"):
                os.remove(f"{output_prefix}_text_sentence.idx")
            if os.path.exists(f"{output_prefix}_text_sentence.bin"):
                os.remove(f"{output_prefix}_text_sentence.bin")
        print(f"Finished preprocessing chunk in {time.time() - start} sec")



if __name__ == '__main__':

    num_workers = 20
    file_path = "/users/jf3516/pile-enron-emails/out/enron_emails"  # Update this path to your decompressed files
    output_path = "/users/jf3516/Megatron-DeepSpeed/examples_deepspeed/rebase/dataset/"

    # Replace 'bert-large-uncased-vocab.txt' with the appropriate GPT vocabulary file
    vocab_file = "/users/jf3516/Megatron-DeepSpeed/examples_deepspeed/rebase/gpt2-vocab.json"  # Update this to the path of your GPT vocabulary file
    merge_file = "/users/jf3516/Megatron-DeepSpeed/examples_deepspeed/rebase/gpt2-merges.txt"

    pile_preprocess(file_path, output_path, merge_file, vocab_file, num_workers)
    # pile_merge(output_path)
    # pile_merge()