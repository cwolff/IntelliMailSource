; Last modified : Sun 9-Oct-88 at 10:50 am
;
; *******************************************************************
; *                                                                 *
; * NBRDRV - Returns the letter of the highest drive                *
; *                                                                 *
; * In Clipper:                                                     *
; *     HIGHEST_DRV = Nbrdrv()                                      *
; *                                                                 *
; *******************************************************************
;

public 			nbrdrv		; decler number of drives as public

extrn			__RETC:FAR	; return value back to clipper

DGROUP	group 		DATASG		; combine data segment
					; with clipper data segment

DATASG	segment		'DATA'		; start of data segment

drive	db		00h,00h

DATASG	ends				; end of data segment

_PROG	segment		'CODE'		; start of code segment

	assume		cs:_PROG,ds:DGROUP

nbrdrv	proc		far

	push		bp		; save resister
	
	mov		bp, sp

	push		ds
	push		es
	push		si
	push		di

	mov		ah, 19h		; get default drive
	int		21h

	mov		dl, al		; ds - set current drive to default
	mov		ah, 0eh		; set drive (return # of drives in al)
	int		21h

	dec		al
	add		al, 41h		; al - the letter value of the
					; highest drive added to "A"
	mov		drive, al	; save in drive string

	mov		ax, DATASG
	push		ax
	mov		ax, offset drive
	push		ax

	call		__RETC		; Clipper return (A, B, ... N)

	add		sp, 4

	pop		di
	pop		si
	pop		es
	pop		ds

	pop		bp

	ret

NBRDRV	ENDP

_PROG	ENDS

	END
	
