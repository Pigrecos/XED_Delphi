unit XED.OperandTypeEnum;

{$Z4}
interface

type
  TXED_Operand_Type_Enum = (
      XED_OPERAND_TYPE_INVALID,
      XED_OPERAND_TYPE_ERROR,
      XED_OPERAND_TYPE_IMM,
      XED_OPERAND_TYPE_IMM_CONST,
      XED_OPERAND_TYPE_NT_LOOKUP_FN,
      XED_OPERAND_TYPE_NT_LOOKUP_FN2,
      XED_OPERAND_TYPE_NT_LOOKUP_FN4,
      XED_OPERAND_TYPE_REG,
      XED_OPERAND_TYPE_LAST);

/// This converts strings to #xed_operand_type_enum_t types.
/// @param s A C-string.
/// @return #xed_operand_type_enum_t
/// @ingroup ENUM
function str2xed_operand_type_enum_t(s: PAnsiChar): TXED_Operand_Type_Enum;  cdecl; external 'xed.dll';
/// This converts strings to #xed_operand_type_enum_t types.
/// @param p An enumeration element of type xed_operand_type_enum_t.
/// @return string
/// @ingroup ENUM
function xed_operand_type_enum_t2str(const p: TXED_Operand_Type_Enum): PAnsiChar; cdecl; external 'xed.dll';

/// Returns the last element of the enumeration
/// @return xed_operand_type_enum_t The last element of the enumeration.
/// @ingroup ENUM
function xed_operand_type_enum_t_last:TXED_Operand_Type_Enum;cdecl; external 'xed.dll';

implementation

end.
