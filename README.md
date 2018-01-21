## signAR - _ASL Translator and Learning Tool_

# Inspiration
The idea from this project came about from a very simple question that we could not think of an answer for: why doesn't Google Translate work for sign language? There are estimated to be [around 70 million deaf people in the world](https://wfdeaf.org/faq/) yet the biggest tool for translation doesn't target this demographic. We felt that translation is not only a means of communication between speakers of different languages, but also a way for people to share their cultural background. As such, we decided to tackle the problem of creating a translation engine that could convert ASL (American Sign Language) to English.

# What it does
**signAR** begins with a live camera view prompting the user to point their device at the hand of the signer they'd like to translate. From there, the app can detect finger lettering for most letters in the alphabet allowing signers to spell out what they wish to communicate. When a letter is detected, **signAR** automatically adds it to the in-progress phrase as well as displaying the sign & letter in augmented reality for confirmation.
_(We definitely wish we could have implemented gesture recognition as gestures are at the heart of understanding and using ASL; however, technical and time constraints only allowed for a spelling translator)_
After the user has received the signer's message, it gets saved to an archive of all the previous phrases they have saved from other interactions with signers. The user can even go back to any given phrase they translated and see the corresponding sign for each letter so that they can practice ASL on their own time!

# How we built it
We built this app in Swift 4 using such frameworks as ARKit, CoreML, and Vision (Apple's computer vision). Additionally, we used Microsoft's Custom Vision to build a model around training data that we compiled ourselves.

# Challenges we ran into
One of our biggest challenges was building a model that could effectively distinguish between each letter of the ASL alphabet (which proved very difficult seeing how similar many of the letters are. Six letters are a variation on a fist!). After much trial and error with datasets and images we found on the internet, we decided that it would be best if we made our own data set by taking over 6,000 of our hands under different lighting conditions signing almost every ASL letter. We took some ideas from the workshop on neural networks to further improve our model. Even after all this, our model still isn't as accurate as we would like it to be (The six variations on a fist are truly challenging for our algorithm).

# Accomplishments that we're proud of
We're very proud of the fact that we can detect some letters at all as when we initially started experimenting with CoreML and Microsoft's Custom Vision, the potential for our idea to work seemed very bleek. Though after much trial and error, we were able to build **signAR**, which was a big achievement for the two of us particularly because we are both new to Machine Learning and Augmented Reality.

# What we learned
Coming out of this hackathon, we are leaving with a much stronger understanding of how a neural network functions as well as the reasons why you can't just give an algorithm a bunch of arbitrary pictures and expect it to immediately know ASL!

# What's next for signAR?
The most pertinent feature that we want to implement is gesture recognition as you cannot do ASL without gestures. Additionally, we think that there is a lot of potential for our project to be able to translate between different kinds of sign languages (like translating from American Sign Language to Spanish Sign Language for example).
