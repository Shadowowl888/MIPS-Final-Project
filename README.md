# MIPS Hangman Final Project


## Executive Summary
This MIPS Assembly Hangman Game aims to offer an interactive and educational experience for users to guess words from different genres. Noteworthy findings include the seamless implementation of genre selection, word bank retrieval, and basic hangman logic. Users can input their genre preferences, view a list of words from the selected genre, and attempt to guess the word through a console-based interface. The game currently supports case-sensitive letter guesses, and the hangman logic updates the display based on correct guesses and overall score for the game. However, users may find the case sensitivity counterintuitive. A recommendation for improvement involves refactoring the code to make the game case insensitive and adding a user-friendly interface, enhancing the user experience.

In conclusion, the MIPS Assembly code successfully creates a functional hangman game and lays the foundation for more advanced ideas. The provided framework serves as an educational resource for those interested in MIPS programming, with potential enhancements for a more user-friendly and inclusive experience.


## Introduction
This report contains the documentation for the development of a Hangman Game using the MIPS Assembly language. The primary objective is to create an interactive and educational program allowing users to select a genre, explore a word bank associated with that genre, and engage in the classic and nostalgic hangman guessing game.

The methodology we used was based on the following four things: genre selection and word retrieval, hangman logic implementation, user interface, and educational focus. In regards to genre selection and word retrieval, the users would be able to choose a genre, which would trigger the retrieval of a random word from the respective word bank. The game also features a basic hangman logic that updates the display based on user input, facilitating the guessing process. The program utilizes a console-based interface for user interaction, providing a streamlined experience within the MIPS Assembly environment at the computer hardware level. Lastly, the project emphasizes education purposes, serving as a practical foundational application of MIPS Assembly language concepts for students in the field of computer science and programming. The report provides insights into the implemented code, highlights key findings, proposes recommendations for improvement, and concludes with the overall success of the project, identifying areas for future enhancement.


## Methodology
### Word Selection and Word Retrieval
In our program, we decided on having a set word bank that had a certain theme attached to it. In our case, we chose words that were related to technology. We decided on this theme since it was closely related to all of our majors, which was computer science, and thought it would be interesting to incorporate. In our program, we had functions that would randomly choose words from the word for the user to guess. The user would then get a score based on how many incorrect guesses they had guessed previously. By the end of the game, the user would have a final score based on how many times they played the game.

### Hangman Logic Implementation
The following are the syscall codes we used and the methods that correspond to them. Syscall 12 facilitates the input of single-character guesses from the user. This is part of our main method that checks for input validation as well. Iterative character comparison within the selected word bank word is employed to determine the correctness of the guessed letter. Further, the display is dynamically updated to reveal correctly guessed letters. The rationale for using the respective syscall codes and methods are as follows. Allowing users to input single-character guesses through syscall 12 ensures an interactive and engaging experience. Iterative word comparison and display updates create a dynamic and visually comprehensible hangman game.

### User Interface
For our user interface, we decided on a console-based approach to facilitate communication between the user and the program. We believed that this made it much simpler and nostalgic like the hangman game played back in the day. We used the following syscall codes and methods in our code. Syscall 4 is used to display prompts, messages, and the current state of the word. This was also used to display the hangman figure on the console screen. The insertion of newline characters (syscalls 11 and 4) is employed for improving the visual presentation. The rationale for the specific syscall codes and methods are as follows. Syscall 4 aids in conveying information to the user effectively within the console interface. The incorporation of newline characters enhances the readability and organization of displayed information.

### Educational Focus
We decided to have an educational focus in our Hangman code. The end goal of our project and program was to teach future programmers how they could also implement a Hangman game with the use of MIPS. The method by which we did so was by leaving many comments throughout the code and having an easy-to-read naming convention.


## Results
The preceding photos and captions detail several of the important procedural functions that we used to program the Hangman game. The full implementation and design of the program can be found at the GitHub link at the end of this report. In the end, we weren’t able to display the hangman drawing as we hoped for in the Bitmap display but instead created a scoring system that mimicked the hangman logic that we all know and love.


## Discussion
Developing this Hangman game in MIPS Assembly holds significance in enhancing our understanding and application of low-level programming languages. It served as an excellent introduction to delve into the intricacies of assembly language and gain experience in manipulating registers, memory, control flow, and procedural functions at the hardware level. The project has broadened our implications for improving problem-solving skills and fostering an introduction to the realm of computer architecture.

While Hangman may seem quite simple to develop in high-level programming languages, like Java or Python, MIPS uses the fundamental programming concepts closer to the computer hardware level. Throughout project development, it reinforced our comprehension of these foundational elements, essential for building more complex applications in assembly and other programming languages.

One of the key limitations encountered during the implementation of the game in MIPS was the challenge of input validation. It took some time in the beginning to find an implementation that would include a way to validate the type of characters the user is allowed to enter. This limitation resulted in unintended behaviors and added additional edge cases to find solutions for. Future iterations of the project should incorporate a comprehensive input validation system, ensuring that only valid characters are accepted as user inputs.

Another notable limitation pertains to the case sensitivity of the user input. Due to the MIPS processing, the current implementation distinguishes between uppercase and lowercase letters, leading to the program requiring a specific letter case to be entered by the player. To enhance the user experience and provide a more polished product, future implementation can be done to implement case insensitivity in the input handling mechanism. This adjustment will contribute to a more accurate representation of the game and better user expectations.

In the end, figuring out the details and abstraction of a Bitmap display to show a figure was extremely challenging to maintain the program-player interaction. The user interface in the current implementation is primarily a console-based output. Designing a bit display to enhance user interaction and experience is a crucial aspect that can be addressed for future implementations. Incorporating graphical elements or a more user-friendly text interface with ASCII characters rather than a simple stick figure could significantly elevate the overall experience. Future iterations of the project should prioritize the development of a more intuitive and aesthetically pleasing user interface, ensuring a seamless and enjoyable gameplay environment.


## Conclusion
In conclusion, the creation of a Hangman game in MIPS Assembly has provided a valuable learning experience, allowing us to apply theoretical knowledge to practical scenarios. The significance of the project lies in its role as a stepping stone for mastering assembly language programming and reinforcing fundamental programming concepts. Despite encountering limitations in input validation, case sensitivity, and user interface design, these challenges present opportunities for improvement and refinement in future iterations of the project. As we continue to explore the intricacies of low-level programming, the lessons learned from this project will undoubtedly contribute to our growth as proficient developers in the realm of assembly language.

Embarking on the journey of creating a Hangman game in MIPS Assembly proved to be a fascinating exploration into the marriage of high-level programming concepts and their translation into the intricate realm of low-level languages. The challenge of transforming abstract ideas from higher-level languages into the concise and precise syntax of MIPS Assembly was both intellectually stimulating and rewarding. The hands-on experience allowed for a deeper understanding of memory management, control flow, and the direct manipulation of hardware resources. It was particularly enjoyable to witness the manifestation of fundamental programming principles at the hardware level, reinforcing the significance of a strong foundation in computer science.

Based on this enriching experience, practical recommendations for future endeavors in MIPS Assembly programming emerge. Firstly, a meticulous focus on input validation mechanisms is essential to ensure the robustness and reliability of the application. Incorporating checks for valid input types helps preemptively address potential errors and enhances the overall user experience. Additionally, prioritizing a more visually appealing user interface not only elevates the aesthetic quality of the game but also contributes to a more engaging and immersive user experience. These recommendations stem from the realization that a comprehensive understanding of both high and low-level programming paradigms is crucial for creating well-rounded and effective software solutions. By seamlessly bridging the gap between abstraction and hardware, developers can create programs that not only function reliably but also provide a satisfying and enjoyable experience for users.


## Contributors
This is a CS 2640 project done by Devin Khun, Sidney Nguyen, and Andrew Tarng.

## Project Environment Setup
1. Install [MARS Simulator](https://courses.missouristate.edu/kenvollmar/mars/download.htm)
2. Run the MIPS code using MARS Simulator