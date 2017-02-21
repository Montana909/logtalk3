// This is a generated file. Not intended for manual editing.
package org.logtalk.intellij.psi;

import java.util.List;
import org.jetbrains.annotations.*;
import com.intellij.psi.PsiElement;

public interface LogtalkOperation extends PsiElement {

  @Nullable
  LogtalkCustomBinaryOperation getCustomBinaryOperation();

  @Nullable
  LogtalkCustomLeftOperation getCustomLeftOperation();

  @Nullable
  LogtalkNativeBinaryOperation getNativeBinaryOperation();

  @Nullable
  LogtalkNativeLeftOperation getNativeLeftOperation();

}