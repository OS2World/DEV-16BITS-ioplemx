.386
R2SEG SEGMENT BYTE PUBLIC USE16 'CODE'
      ASSUME  CS:R2SEG, DS:NOTHING

PUBLIC _16_TEST
_16_TEST  PROC  FAR
;
; clear the interrupt flag, so no further interrupts will be accepted
;
  cli
;
; save bp and fetch the pointer to the array from the stack
;
  push bp
  mov bp,sp
  mov es,[bp+8]
  mov bp,[bp+6]

  mov eax,0
  mov edx,1048577       ; write 1048577 integers
loop1:
  mov es:[bp],ax        ; write the integer


  mov cx,100            ; 
loop0:                  ; waste some time, so the users can watch the
  dec cx                ; programm working
  jnz loop0             ;

  inc bp                ; increment pointer to array twice (short int means
  inc bp                ;   two bytes)
  jnz loop3             ; not yet end of segment?
  push ax               ;   
  mov ax,es             ;  otherwise take next segment
  add ax,8              ;
  mov es,ax             ;  Note: this relies on word alignment of the array
  pop ax
loop3:
  inc ax                ; next integer that will be written
  dec edx 
  jnz loop1             ; not yet ready?
end_test:
  mov ax,es             ; return last segment
  pop bp                
  sti                   ; allow interrupts again
  ret   4               ; clean up stack and return
_16_TEST  ENDP

R2SEG   ENDS
   END
