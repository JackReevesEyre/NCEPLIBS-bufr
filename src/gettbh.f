C> @file
C> @brief Read the header lines from a master table B, table D or
C> Code/Flag table

C> This subroutine reads the header lines from two separate ASCII
C> files (one standard and one local) containing master table B,
C> table D or Code/Flag table information.
C>
C> @author J. Ator
C> @date 2007-01-19
C>
C> @param[in] LUNS   -- integer: Fortran logical unit number for
C>                      ASCII file containing standard table
C>                      information
C> @param[in] LUNL   -- integer: Fortran logical unit number for
C>                      ASCII file containing local table
C>                      information
C> @param[out] TAB   -- character: Type of table
C>                        - 'B' = Table B
C>                        - 'D' = Table D
C>                        - 'F' = Code/Flag table
C> @param[out] IMT   -- integer: Master table
C>                      - This value is read from both ASCII
C>                        files and must be identical between them.
C> @param[out] IMTV  -- integer: Version number of master table
C>                      - This value is read from the standard ASCII
C>                        file.
C> @param[out] IOGCE -- integer: Originating center
C>                      - This value is read from the local ASCII
C>                        file.
C> @param[out] ILTV  -- integer: Version number of local table
C>                      - This value is read from the local ASCII
C>                        file.
C>
C> <b>Program history log:</b>
C> | Date | Programmer | Comments |
C> | -----|------------|----------|
C> | 2007-01-19 | J. Ator | Original author |
C>
	SUBROUTINE GETTBH ( LUNS, LUNL, TAB, IMT, IMTV, IOGCE, ILTV )

	CHARACTER*128	BORT_STR
	CHARACTER*40	HEADER
	CHARACTER*30	TAGS(5), LABEL
	CHARACTER*3	CFTYP
	CHARACTER*2	CTTYP
	CHARACTER*1	TAB

	LOGICAL	BADLABEL

C-----------------------------------------------------------------------
C	Statement function to check for bad header line label:

	BADLABEL ( LABEL ) = ( ( INDEX ( LABEL, CTTYP ) .EQ. 0 ) .OR.
     .			       ( INDEX ( LABEL, CFTYP ) .EQ. 0 ) )
C-----------------------------------------------------------------------

	CTTYP = TAB // ' '

C	Read and parse the header line of the standard file.

	CFTYP = 'STD'
	IF ( IGETNTBL ( LUNS, HEADER ) .NE. 0 ) GOTO 900
	CALL PARSTR ( HEADER, TAGS, 5, NTAG, '|', .FALSE. )
	IF ( NTAG .LT. 3 ) GOTO 900
	IF ( BADLABEL ( TAGS(1) ) ) GOTO 900
	IMT = VALX ( TAGS(2) )
	IMTV = VALX ( TAGS(3) )
	
C	Read and parse the header line of the local file.

	CFTYP = 'LOC'
	IF ( IGETNTBL ( LUNL, HEADER ) .NE. 0 ) GOTO 900
	CALL PARSTR ( HEADER, TAGS, 5, NTAG, '|', .FALSE. )
	IF ( NTAG .LT. 4 ) GOTO 900
	IF ( BADLABEL ( TAGS(1) ) ) GOTO 900
	IMT2 = VALX ( TAGS(2) )
	IOGCE = VALX ( TAGS(3) )
	ILTV = VALX ( TAGS(4) )
	
C	Verify that both files are for the same master table.

	IF ( IMT .NE. IMT2 ) GOTO 901

	RETURN

 900	WRITE(BORT_STR,'("BUFRLIB: GETTBH - BAD OR MISSING HEADER '//
     .    'WITHIN ",A," TABLE ",A)') CFTYP, TAB
	CALL BORT(BORT_STR)
 901	WRITE(BORT_STR,'("BUFRLIB: GETTBH - MASTER TABLE NUMBER '//
     .    'MISMATCH BETWEEN STD AND LOC TABLE ",A)') TAB
	CALL BORT(BORT_STR)
	END
