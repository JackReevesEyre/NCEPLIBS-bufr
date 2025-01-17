C> @file
C> @brief Read a specified data subset from internal arrays.

C> This subroutine provides a handy way to combine the functionality
C> of subroutines rdmemm() and rdmems() within a single subroutine
C> call.
C>
C> @author J. Woollen
C> @date 1994-01-06
C>
C> @param[in] IMSG   -- integer: Number of BUFR message to be
C>                      read into scope for further processing,
C>                      counting from the beginning of the
C>                      internal arrays in memory
C> @param[in] ISUB   -- integer: Number of data subset to be
C>                      read from the (IMSG)th BUFR message,
C>                      counting from the beginning of the message
C> @param[out] SUBSET -- character*8: Table A mnemonic for type of
C>                       (IMSG)th BUFR message
C>                       (see [DX BUFR Tables](@ref dfbftab) for
C>                       further information about Table A mnemonics)
C> @param[out] JDATE -- integer: Date-time stored within Section 1 of
C>                      (IMSG)th BUFR message, in format of either
C>                      YYMMDDHH or YYYYMMDDHH, depending on the most
C>                      recent call to subroutine datelen()
C>
C> <p>Whenever this subroutine returns successfully, the requested data
C> subset can now be easily manipulated or further parsed via calls to
C> any of the [values-reading subroutines](@ref hierarchy) using the
C> Fortran logical unit number IUNIT that was returned from the most
C> recent call to subroutine ufbmem().
C>
C> <b>Program history log:</b>
C> | Date | Programmer | Comments |
C> | -----|------------|----------|
C> | 1994-01-06 | J. Woollen | Original author |
C> | 1998-07-08 | J. Woollen | Replaced call to Cray library routine "ABORT" with call to new internal routine bort() |
C> | 1999-11-18 | J. Woollen | Increased MAXMEM from 4 Mb to 8 Mb |
C> | 2001-08-15 | D. Keyser  | Increased MAXMEM from 8 Mb to 16 Mb |
C> | 2004-11-15 | D. Keyser  | Increased MAXMEM from 16 Mb to 50 Mb |
C> | 2014-12-10 | J. Ator    | Use modules instead of COMMON blocks |
C>
      SUBROUTINE UFBMMS(IMSG,ISUB,SUBSET,JDATE)

      USE MODA_MSGCWD
      USE MODA_MSGMEM

      CHARACTER*128 BORT_STR
      CHARACTER*8   SUBSET

C-----------------------------------------------------------------------
C-----------------------------------------------------------------------

C  READ SUBSET #ISUB FROM MEMORY MESSAGE #IMSG
C  -------------------------------------------

      CALL RDMEMM(IMSG,SUBSET,JDATE,IRET)
      IF(IRET.LT.0) GOTO 900
      CALL RDMEMS(ISUB,IRET)
      IF(IRET.NE.0) GOTO 901

C  EXITS
C  -----

      RETURN
900   IF(IMSG.GT.0)  THEN
      WRITE(BORT_STR,'("BUFRLIB: UFBMMS - REQUESTED MEMORY MESSAGE '//
     . 'NUMBER TO READ IN (",I5,") EXCEEDS THE NUMBER OF MESSAGES IN '//
     . 'MEMORY (",I5,")")') IMSG,MSGP(0)
      ELSE
      WRITE(BORT_STR,'("BUFRLIB: UFBMMS - REQUESTED MEMORY MESSAGE '//
     . 'NUMBER TO READ IN IS ZERO - THIS IS NOT VALID")')
      ENDIF
      CALL BORT(BORT_STR)
901   CALL STATUS(MUNIT,LUN,IL,IM)
      WRITE(BORT_STR,'("BUFRLIB: UFBMMS - REQ. SUBSET NUMBER TO READ '//
     . 'IN (",I3,") EXCEEDS THE NUMBER OF SUBSETS (",I3,") IN THE '//
     . 'REG. MEMORY MESSAGE (",I5,")")') ISUB,MSUB(LUN),IMSG
      CALL BORT(BORT_STR)
      END
