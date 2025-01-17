C> @file
C> @brief Check whether a descriptor is standard

C> Given the bit-wise (integer) representation of a descriptor, this
C> function determines whether the descriptor is WMO-standard.
C>
C> <p>If a descriptor is not WMO-standard, then by definition it is a
C> local descriptor.
C>
C> @author J. Ator
C> @date 2004-08-18
C>
C> @param[in] IDN -- integer: Bit-wise representation of FXY value for
C>                   descriptor
C> @returns istdesc -- integer: Flag indicating whether IDN is a
C>                     WMO-standard descriptor:
C>                        - 0 = No
C>                        - 1 = Yes
C>
C> <b>Program history log:</b>
C> | Date | Programmer | Comments |
C> | -----|------------|----------|
C> | 2004-08-18 | J. Ator | Original author |
C>
	FUNCTION ISTDESC( IDN )

	CHARACTER*6	ADSC, ADN30

	ADSC = ADN30( IDN, 6 )

	READ(ADSC,'(I1,I2,I3)') IF,IX,IY
	IF ( IF .EQ. 1 ) THEN

C	    ADSC IS A REPLICATION DESCRIPTOR AND THEREFORE STANDARD
C	    BY DEFAULT.

	    ISTDESC = 1
	ELSE IF ( IF .EQ. 2 ) THEN

C	    ADSC IS AN OPERATOR DESCRIPTOR

	    ISTDESC = IOKOPER( ADSC )
	ELSE IF ( ( IX .LT. 48 ) .AND. ( IY .LT. 192 ) ) THEN
	    ISTDESC = 1
	ELSE
	    ISTDESC = 0
	END IF

	RETURN
	END
