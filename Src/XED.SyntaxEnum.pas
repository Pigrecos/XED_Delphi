unit XED.SyntaxEnum;

{$Z4}
interface

type
  TXED_Syntax_Enum = (
      XED_SYNTAX_INVALID,
      XED_SYNTAX_XED, ///< XED disassembly syntax
      XED_SYNTAX_ATT, ///< ATT SYSV disassembly syntax
      XED_SYNTAX_INTEL, ///< Intel disassembly syntax
      XED_SYNTAX_LAST);

/// This converts strings to #xed_operand_action_enum_t types.
/// @param s A C-string.
/// @return #xed_operand_action_enum_t
/// @ingroup ENUM
function str2xed_syntax_enum_t(s: PAnsiChar): TXED_Syntax_Enum;  cdecl; external 'xed.dll';
/// This converts strings to #xed_operand_action_enum_t types.
/// @param p An enumeration element of type xed_operand_action_enum_t.
/// @return string
/// @ingroup ENUM
function xed_syntax_enum_t2str(const p: TXED_Syntax_Enum): PAnsiChar; cdecl; external 'xed.dll';

/// Returns the last element of the enumeration
/// @return xed_operand_action_enum_t The last element of the enumeration.
/// @ingroup ENUM
function xed_syntax_enum_t_last:TXED_Syntax_Enum;cdecl; external 'xed.dll';

implementation

end.
