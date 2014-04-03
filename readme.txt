Hi folks,

some time ago I posted an article to comp.os.os2.programmer.misc where I asked
whether it's possible to stop the multitasking in OS/2 without writing a
device driver. I want to do some measurement under OS/2 as I did under DOS,
but in DOS you have always this boring problem with the 64KByte memory limit.

So the idea was to write a C programm that allocates some memory (e.g. 2MB)
and then jump to an assembler routine that fills the array with the measured
data on the basis of a programmed timer WITHOUT getting any interrupts, 
so that the timing of the data would be reliable.

Actually, there were to different answers to my article. Some people said, that
it would be necessary to write a device driver for my A/D card, other people
told me, it would be sufficient to create an IOPL-segment in my program to
do the job. But no one told me how to do it in an emx+gcc environment.

Perhaps this is common knowledge for you, but it did cost me really some
time to get the things working. So I put together an example that shows how
to create an IPOL segment with emx+gcc. 

I put it on hobbes.nmsu.edu and on ftp.informatik.tu-muenchen.de.
Its name ist iopl_test.zip.

The program has two parts, a C file (test_iopl.c), that allocates 2MB of 
short integers and an assembler file (iopl.asm) that fills the allocated 
memory with integers. To compile it you need a MASM (I used MASM 5.1, I don't
know whether other versions will work, but I hope so) and the emx port of
gcc. Please have a look at the makefile, because in my system there's 
at the moment no PATH to masm, so I put the path in the makefile. Perhaps
you have to modify it.

The assembler file exports one routine, _16_TEST, please note that the
praefix _16_ is necessary, because emx+gcc adds the praefix to your
declared thunk function.
This routine fills the allocated array with successive integers, while the
interrupts are disabled. I put a time delay in the routine, so you can watch
how the mousepointer stands still, while the routine works. It takes about
5 seconds on my machine (486DX2-50).

In the C file, the array is allocated, then the assembler routine is called
and finally every 64th member of the array is written to a file, so you can
see that it's working. (Note: it takes about 360KByte of free disk space).

--------------------------------------------------------------------------------

NO WARRANTY !! NO WARRANTY !! NO WARRANTY !! NO WARRANTY !! NO WARRANTY !! 

YOU ARE USING THIS CODE AND RUNNING THE PROGRAM ON YOUR OWN RISK !!

--------------------------------------------------------------------------------

In fact it is a very easy way to completly stop your machine by using 
privileged code and making mistakes [I know what I'm talking about 8-( ]

I hope, that this code is useful, but maybe it's not. The program works fine
on my machine, but maybe it does not on yours. I didn't include error checking,
because I think, if anybody wants to stop interrupts he should know what
he's doing.

Especially what I didn't do is checking the problem of swapping. I allocate
the m,emory with calloc, so it is filled with 0. If you have enough RAM
this means that the whole array is in the RAM. I do not know, what happens,
if swapping occurs while the interrupts are disabled. On my machine it works,
I have 8 MB of RAM in it.

A final word: The Code isn't elegant, I think, but I'm not a programming wizard
and it just does, what I wanted it to do. 8-)

So at last I want to thank the peopole who answered me to my last posting
an to the writers of io386.zip, and naturally Eberhard Matthes, who did this
great work of bringing emx+gcc to us.

ARMIN LAMBACHER

--------------------------------------------------------------------------------
Armin Lambacher                            email: lambache@alf.biochem.mpg.de
Abt. Membran- und Neurophysik
MPI fuer Biochemie
Martinsried

"Ich sag' nicht viel, aber was ich sag' ist Quatsch." (Pippi Langstrumpf)

--------------------------------------------------------------------------------
