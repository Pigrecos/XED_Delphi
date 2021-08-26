unit XED.RegClassEnum;

{$Z4}
interface

type
  TXED_Reg_Class_enum = (
      XED_REG_CLASS_INVALID,
      XED_REG_CLASS_BNDCFG,
      XED_REG_CLASS_BNDSTAT,
      XED_REG_CLASS_BOUND,
      XED_REG_CLASS_CR,
      XED_REG_CLASS_DR,
      XED_REG_CLASS_FLAGS,
      XED_REG_CLASS_GPR,
      XED_REG_CLASS_GPR16,
      XED_REG_CLASS_GPR32,
      XED_REG_CLASS_GPR64,
      XED_REG_CLASS_GPR8,
      XED_REG_CLASS_IP,
      XED_REG_CLASS_MASK,
      XED_REG_CLASS_MMX,
      XED_REG_CLASS_MSR,
      XED_REG_CLASS_MXCSR,
      XED_REG_CLASS_PSEUDO,
      XED_REG_CLASS_PSEUDOX87,
      XED_REG_CLASS_SR,
      XED_REG_CLASS_TMP,
      XED_REG_CLASS_TREG,
      XED_REG_CLASS_UIF,
      XED_REG_CLASS_X87,
      XED_REG_CLASS_XCR,
      XED_REG_CLASS_XMM,
      XED_REG_CLASS_YMM,
      XED_REG_CLASS_ZMM,
      XED_REG_CLASS_LAST);

/// This converts strings to #xed_reg_class_enum_t types.
/// @param s A C-string.
/// @return #xed_reg_class_enum_t
/// @ingroup ENUM
function str2xed_reg_class_enum_t(s: PAnsiChar): TXED_Reg_Class_enum;  cdecl; external 'xed.dll';
/// This converts strings to #xed_reg_class_enum_t types.
/// @param p An enumeration element of type xed_reg_class_enum_t.
/// @return string
/// @ingroup ENUM
function xed_reg_class_enum_t2str(const p: TXED_Reg_Class_enum): PAnsiChar; cdecl; external 'xed.dll';

/// Returns the last element of the enumeration
/// @return xed_reg_class_enum_t The last element of the enumeration.
/// @ingroup ENUM
function xed_reg_class_enum_t_last:TXED_Reg_Class_enum;cdecl; external 'xed.dll';

implementation

end.
