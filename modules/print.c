int vgaPos = 0;

void writeLine(const char* sentence, const int color) {
    int sentencePointer = 0;
    volatile char* videoMemory = (volatile char*)0xB8000;

    while (sentence[sentencePointer] != 0) {
        videoMemory[vgaPos] = sentence[sentencePointer];
        videoMemory[vgaPos + 1] = color;
        sentencePointer = sentencePointer + 1;
        vgaPos = vgaPos + 2;
    }
}
