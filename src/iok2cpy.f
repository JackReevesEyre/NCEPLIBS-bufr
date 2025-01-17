C> @file
C> @brief Check whether a BUFR message or data subset can be copied
C> from one BUFR file to another.

C> This function determines whether a BUFR message, or a data subset
C> from within a BUFR message, can be copied from one Fortran logical
C> unit to another.
C>
C> <p>The decision is based on whether both logical units contain
C> identical definitions for the BUFR message type in question within
C> their associated [DX BUFR Table information](@ref dfbftab).
C> Note that it's possible for a BUFR message type to be identically
C> defined for two different logical units even if the full set of
C> associated DX BUFR table information isn't identical between both
C> units.
C>
C> @author J. Ator
C> @date 2009-06-26
C>
C> @param[in]  LUI     -- integer: Internal I/O stream index associated
C>                        with source BUFR file
C> @param[in]  LUO     -- integer: Internal I/O stream index associated
C>                        with target BUFR file
C> @returns iok2cpy    -- integer: Flag indicating whether a BUFR
C>                        message or data subset can be copied from the
C>                        BUFR file associated with LUI to the BUFR file
C>                        associated with LUO
C>                        - 0 = No
C>                        - 1 = Yes
C>
C> <b>Program history log:</b>
C> | Date | Programmer | Comments |
C> | -----|------------|----------|
C> | 2009-06-26 | J. Ator | Original author |
C> | 2014-12-10 | J. Ator | Use modules instead of COMMON blocks |
C>
      INTEGER FUNCTION IOK2CPY(LUI,LUO)

      USE MODA_MSGCWD
      USE MODA_TABLES

      CHARACTER*8  SUBSET

C-----------------------------------------------------------------------
C-----------------------------------------------------------------------

      IOK2CPY = 0

C     Do both logical units have the same internal table information?

      IF ( ICMPDX(LUI,LUO) .EQ. 1 ) THEN
	IOK2CPY = 1
	RETURN
      ENDIF
 
C     No, so get the Table A mnemonic from the message to be copied,
C     then check whether that mnemonic is defined within the dictionary
C     tables for the logical unit to be copied to.

      SUBSET = TAG(INODE(LUI))
      CALL NEMTBAX(LUO,SUBSET,MTYP,MSBT,INOD)
      IF ( INOD .EQ. 0 ) RETURN

C     The Table A mnemonic is defined within the dictionary tables for
C     both units, so now make sure the definitions are identical.

      NTEI = ISC(INODE(LUI))-INODE(LUI)
      NTEO = ISC(INOD)-INOD
      IF ( NTEI .NE. NTEO ) RETURN

      DO I = 1, NTEI
        IF ( TAG(INODE(LUI)+I) .NE. TAG(INOD+I) ) RETURN
        IF ( TYP(INODE(LUI)+I) .NE. TYP(INOD+I) ) RETURN
        IF ( ISC(INODE(LUI)+I) .NE. ISC(INOD+I) ) RETURN
        IF ( IRF(INODE(LUI)+I) .NE. IRF(INOD+I) ) RETURN
        IF ( IBT(INODE(LUI)+I) .NE. IBT(INOD+I) ) RETURN
      ENDDO

      IOK2CPY = 1

      RETURN
      END
