unit XED.OperandActionEnum;

{$Z4}
interface

type
  TXED_Operand_Action_Enum = (
      XED_OPERAND_ACTION_INVALID,
      XED_OPERAND_ACTION_RW,       ///< Read and written (must write)
      XED_OPERAND_ACTION_R,        ///< Read-only
      XED_OPERAND_ACTION_W,        ///< Write-only (must write)
      XED_OPERAND_ACTION_RCW,      ///< Read and conditionlly written (may write)
      XED_OPERAND_ACTION_CW,       ///< Conditionlly written (may write)
      XED_OPERAND_ACTION_CRW,      ///< Conditionlly read, always written (must write)
      XED_OPERAND_ACTION_CR,       ///< Conditional read
      XED_OPERAND_ACTION_LAST);

/// This converts strings to #xed_operand_action_enum_t types.
/// @param s A C-string.
/// @return #xed_operand_action_enum_t
/// @ingroup ENUM
function str2xed_operand_action_enum_t(s: PAnsiChar): TXED_Operand_Action_Enum;  cdecl; external 'xed.dll';
/// This converts strings to #xed_operand_action_enum_t types.
/// @param p An enumeration element of type xed_operand_action_enum_t.
/// @return string
/// @ingroup ENUM
function xed_operand_action_enum_t2str(const p: TXED_Operand_Action_Enum): PAnsiChar; cdecl; external 'xed.dll';

/// Returns the last element of the enumeration
/// @return xed_operand_action_enum_t The last element of the enumeration.
/// @ingroup ENUM
function xed_operand_action_enum_t_last:TXED_Operand_Action_Enum;cdecl; external 'xed.dll';

implementation

end.
