import glob

class SpellChecker(object):
    def __init__(self):
        self.words = []

    def load_file(self, file_name):
         # lines = open(file_name).readlines() # don't use this on python 3.7
         with open(file_name, 'r') as l:
             lines = l.readlines()
             return list(map(lambda x: x.strip().lower(), lines))

    def load_words(self, file_name):
        self.words = self.load_file(file_name)
        
    def load_dir_words(self, dir_name):
        for e_name in glob.glob(dir_name):       
            for line in self.load_file(e_name):
                self.words.append(line)

    def check_profanities(self, word):
        return word not in ['fuck', 'shit']
        
    def check_word(self, word):
        return word.lower().strip('.,?\"') in self.words
    
    def check_words(self, sentence, index=0):
        failed_words = []
        words_to_check = sentence.split(' ')
        caret_position = 0
        for word in words_to_check:
            if not self.check_word(word):
                failed_words.append(
                    {'word':word, 'line':index+1,
                        'pos':caret_position+1, 'type': 'spelling'})
            if not self.check_profanities(word):
                failed_words.append(
                    {'word':word, 'line':index+1,
                        'pos':caret_position+1, 'type': 'profanity'})
            caret_position += len(word) + 1
        return failed_words

    def check_document(self, file_name):
        failed_words_in_sentences = []
        self.sentences = self.load_file(file_name)
        for index, sentence in enumerate(self.sentences):
            failed_words_in_sentences.extend(
                self.check_words(sentence, index))
        return failed_words_in_sentences

if __name__ == '__main__':
   
    spell_checker = SpellChecker()
    spell_checker.load_words('spell.words')
    # now check if the word zygotic is a word
    print(spell_checker.check_word('zygotic'))
    print(spell_checker.check_word('mistasdas'))
    print(spell_checker.check_words('zygotic mistasdas elementary'))