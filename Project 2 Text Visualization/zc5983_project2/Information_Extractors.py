from collections import defaultdict
import re
import os

def clean_and_split_text(text):
    words = re.findall(r'\b[a-zA-Z]+\b', text.lower())
    return words

def generate_allwords(words, filename='zc5983_project2/data/allwords.txt'):
    with open(filename, 'w') as f:
        for word in words:
            f.write(word + '\n')

def generate_uniquewords(words, filename='zc5983_project2/data/uniquewords.txt'):
    word_count = defaultdict(int)
    for word in words:
        word_count[word] += 1
    unique_words = [word for word, count in word_count.items() if count == 1]
    with open(filename, 'w') as f:
        for word in unique_words:
            f.write(word + '\n')

def generate_wordcounts(words, filename='zc5983_project2/data/wordcounts.txt'):
    word_count = defaultdict(int)
    for word in words:
        word_count[word] += 1
    frequency_count = defaultdict(int)
    for count in word_count.values():
        frequency_count[count] += 1
    with open(filename, 'w') as f:
        for freq in sorted(frequency_count):
            f.write(f"{freq}: {frequency_count[freq]}\n")

def main():
    os.makedirs('data', exist_ok=True)

    # Ask ChatGPT to debug this
    with open('zc5983_project2\data\source.txt', 'r', encoding='utf-8') as f:
        book_text = f.read()

    words = clean_and_split_text(book_text)
    
    generate_allwords(words)
    generate_uniquewords(words)
    generate_wordcounts(words)

if __name__ == "__main__":
    main()
