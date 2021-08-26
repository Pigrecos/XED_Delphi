unit XED.OperandVisibilityEnum;

{$Z4}
interface

type
  TXED_Operand_Visibility_Enum = (
      XED_OPVIS_INVALID,
      XED_OPVIS_EXPLICIT, ///< Shows up in operand encoding
      XED_OPVIS_IMPLICIT, ///< Part of the opcode, but listed as an operand
      XED_OPVIS_SUPPRESSED, ///< Part of the opcode, but not typically listed as an operand
      XED_OPVIS_LAST);

/// This converts strings to #xed_operand_type_enum_t types.
/// @param s A C-string.
/// @return #xed_operand_type_enum_t
/// @ingroup ENUM
function str2xed_operand_visibility_enum_t(s: PAnsiChar): TXED_Operand_Visibility_Enum;  cdecl; external 'xed.dll';
/// This converts strings to #xed_operand_type_enum_t types.
/// @param p An enumeration element of type xed_operand_type_enum_t.
/// @return string
/// @ingroup ENUM
function xed_operand_visibility_enum_t2str(const p: TXED_Operand_Visibility_Enum): PAnsiChar; cdecl; external 'xed.dll';

/// Returns the last element of the enumeration
/// @return xed_operand_type_enum_t The last element of the enumeration.
/// @ingroup ENUM
function xed_operand_visibility_enum_t_last:TXED_Operand_Visibility_Enum;cdecl; external 'xed.dll';

implementation

end.
