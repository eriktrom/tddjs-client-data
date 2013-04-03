ToDo
====

1. Accessing a public property and making wild assumptions about the implementation
   of Observable is an issue. An observable object should be observable by
   any number of objects, but it is of no interest to outsiders how or where the
   observable stores them. Ideally, we would like to be able to check with the
   observable if a certain observer is registered without groping around its
   insides. This is a smell, this is the note for the smell.