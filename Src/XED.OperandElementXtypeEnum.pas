unit XED.OperandElementXtypeEnum;

{$Z4}
interface

type
  TXED_Operand_Element_Xtype_Enum = (
      XED_OPERAND_XTYPE_INVALID,
      XED_OPERAND_XTYPE_2F16,
      XED_OPERAND_XTYPE_B80,
      XED_OPERAND_XTYPE_BF16,
      XED_OPERAND_XTYPE_F16,
      XED_OPERAND_XTYPE_F32,
      XED_OPERAND_XTYPE_F64,
      XED_OPERAND_XTYPE_F80,
      XED_OPERAND_XTYPE_I1,
      XED_OPERAND_XTYPE_I16,
      XED_OPERAND_XTYPE_I32,
      XED_OPERAND_XTYPE_I64,
      XED_OPERAND_XTYPE_I8,
      XED_OPERAND_XTYPE_INT,
      XED_OPERAND_XTYPE_STRUCT,
      XED_OPERAND_XTYPE_U128,
      XED_OPERAND_XTYPE_U16,
      XED_OPERAND_XTYPE_U256,
      XED_OPERAND_XTYPE_U32,
      XED_OPERAND_XTYPE_U64,
      XED_OPERAND_XTYPE_U8,
      XED_OPERAND_XTYPE_UINT,
      XED_OPERAND_XTYPE_VAR,
      XED_OPERAND_XTYPE_LAST);

/// This converts strings to #xed_operand_element_xtype_enum_t types.
/// @param s A C-string.
/// @return #xed_operand_element_xtype_enum_t
/// @ingroup ENUM
function str2xed_operand_element_xtype_enum_t(s: PAnsiChar): TXED_Operand_Element_Xtype_Enum;  cdecl; external 'xed.dll';
/// This converts strings to #xed_operand_element_xtype_enum_t types.
/// @param p An enumeration element of type xed_operand_element_xtype_enum_t.
/// @return string
/// @ingroup ENUM
function xed_operand_element_xtype_enum_t2str(const p: TXED_Operand_Element_Xtype_Enum): PAnsiChar; cdecl; external 'xed.dll';

/// Returns the last element of the enumeration
/// @return xed_operand_element_xtype_enum_t The last element of the enumeration.
/// @ingroup ENUM
function xed_operand_element_xtype_enum_t_last:TXED_Operand_Element_Xtype_Enum;cdecl; external 'xed.dll';

implementation

end.
