// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
//
// This file has been automatically generated.  Please do not edit it manually.
// To regenerate the file, use the script "pkg/analyzer/tool/generate_files".

library analyzer.src.summary.format;

import 'flat_buffers.dart' as fb;
import 'idl.dart' as idl;

class _ReferenceKindReader extends fb.Reader<idl.ReferenceKind> {
  const _ReferenceKindReader() : super();

  @override
  int get size => 4;

  @override
  idl.ReferenceKind read(fb.BufferPointer bp) {
    int index = const fb.Uint32Reader().read(bp);
    return idl.ReferenceKind.values[index];
  }
}

class _UnlinkedConstOperationReader extends fb.Reader<idl.UnlinkedConstOperation> {
  const _UnlinkedConstOperationReader() : super();

  @override
  int get size => 4;

  @override
  idl.UnlinkedConstOperation read(fb.BufferPointer bp) {
    int index = const fb.Uint32Reader().read(bp);
    return idl.UnlinkedConstOperation.values[index];
  }
}

class _UnlinkedExecutableKindReader extends fb.Reader<idl.UnlinkedExecutableKind> {
  const _UnlinkedExecutableKindReader() : super();

  @override
  int get size => 4;

  @override
  idl.UnlinkedExecutableKind read(fb.BufferPointer bp) {
    int index = const fb.Uint32Reader().read(bp);
    return idl.UnlinkedExecutableKind.values[index];
  }
}

class _UnlinkedParamKindReader extends fb.Reader<idl.UnlinkedParamKind> {
  const _UnlinkedParamKindReader() : super();

  @override
  int get size => 4;

  @override
  idl.UnlinkedParamKind read(fb.BufferPointer bp) {
    int index = const fb.Uint32Reader().read(bp);
    return idl.UnlinkedParamKind.values[index];
  }
}

class EntityRefBuilder extends Object with _EntityRefMixin implements idl.EntityRef {
  bool _finished = false;

  int _slot;
  int _reference;
  int _paramReference;
  List<int> _implicitFunctionTypeIndices;
  List<EntityRefBuilder> _typeArguments;

  @override
  int get slot => _slot ??= 0;

  /**
   * If this [EntityRef] is contained within [LinkedUnit.types], slot id (which
   * is unique within the compilation unit) identifying the target of type
   * propagation or type inference with which this [EntityRef] is associated.
   *
   * Otherwise zero.
   */
  void set slot(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _slot = _value;
  }

  @override
  int get reference => _reference ??= 0;

  /**
   * Index into [UnlinkedUnit.references] for the entity being referred to, or
   * zero if this is a reference to a type parameter.
   */
  void set reference(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _reference = _value;
  }

  @override
  int get paramReference => _paramReference ??= 0;

  /**
   * If this is a reference to a type parameter, one-based index into the list
   * of [UnlinkedTypeParam]s currently in effect.  Indexing is done using De
   * Bruijn index conventions; that is, innermost parameters come first, and
   * if a class or method has multiple parameters, they are indexed from right
   * to left.  So for instance, if the enclosing declaration is
   *
   *     class C<T,U> {
   *       m<V,W> {
   *         ...
   *       }
   *     }
   *
   * Then [paramReference] values of 1, 2, 3, and 4 represent W, V, U, and T,
   * respectively.
   *
   * If the type being referred to is not a type parameter, [paramReference] is
   * zero.
   */
  void set paramReference(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _paramReference = _value;
  }

  @override
  List<int> get implicitFunctionTypeIndices => _implicitFunctionTypeIndices ??= <int>[];

  /**
   * If this is a reference to a function type implicitly defined by a
   * function-typed parameter, a list of zero-based indices indicating the path
   * from the entity referred to by [reference] to the appropriate type
   * parameter.  Otherwise the empty list.
   *
   * If there are N indices in this list, then the entity being referred to is
   * the function type implicitly defined by a function-typed parameter of a
   * function-typed parameter, to N levels of nesting.  The first index in the
   * list refers to the outermost level of nesting; for example if [reference]
   * refers to the entity defined by:
   *
   *     void f(x, void g(y, z, int h(String w))) { ... }
   *
   * Then to refer to the function type implicitly defined by parameter `h`
   * (which is parameter 2 of parameter 1 of `f`), then
   * [implicitFunctionTypeIndices] should be [1, 2].
   *
   * Note that if the entity being referred to is a generic method inside a
   * generic class, then the type arguments in [typeArguments] are applied
   * first to the class and then to the method.
   */
  void set implicitFunctionTypeIndices(List<int> _value) {
    assert(!_finished);
    assert(_value == null || _value.every((e) => e >= 0));
    _implicitFunctionTypeIndices = _value;
  }

  @override
  List<EntityRefBuilder> get typeArguments => _typeArguments ??= <EntityRefBuilder>[];

  /**
   * If this is an instantiation of a generic type or generic executable, the
   * type arguments used to instantiate it.  Trailing type arguments of type
   * `dynamic` are omitted.
   */
  void set typeArguments(List<EntityRefBuilder> _value) {
    assert(!_finished);
    _typeArguments = _value;
  }

  EntityRefBuilder({int slot, int reference, int paramReference, List<int> implicitFunctionTypeIndices, List<EntityRefBuilder> typeArguments})
    : _slot = slot,
      _reference = reference,
      _paramReference = paramReference,
      _implicitFunctionTypeIndices = implicitFunctionTypeIndices,
      _typeArguments = typeArguments;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_implicitFunctionTypeIndices;
    fb.Offset offset_typeArguments;
    if (!(_implicitFunctionTypeIndices == null || _implicitFunctionTypeIndices.isEmpty)) {
      offset_implicitFunctionTypeIndices = fbBuilder.writeListUint32(_implicitFunctionTypeIndices);
    }
    if (!(_typeArguments == null || _typeArguments.isEmpty)) {
      offset_typeArguments = fbBuilder.writeList(_typeArguments.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (_slot != null && _slot != 0) {
      fbBuilder.addUint32(0, _slot);
    }
    if (_reference != null && _reference != 0) {
      fbBuilder.addUint32(1, _reference);
    }
    if (_paramReference != null && _paramReference != 0) {
      fbBuilder.addUint32(2, _paramReference);
    }
    if (offset_implicitFunctionTypeIndices != null) {
      fbBuilder.addOffset(3, offset_implicitFunctionTypeIndices);
    }
    if (offset_typeArguments != null) {
      fbBuilder.addOffset(4, offset_typeArguments);
    }
    return fbBuilder.endTable();
  }
}

class _EntityRefReader extends fb.TableReader<_EntityRefImpl> {
  const _EntityRefReader();

  @override
  _EntityRefImpl createObject(fb.BufferPointer bp) => new _EntityRefImpl(bp);
}

class _EntityRefImpl extends Object with _EntityRefMixin implements idl.EntityRef {
  final fb.BufferPointer _bp;

  _EntityRefImpl(this._bp);

  int _slot;
  int _reference;
  int _paramReference;
  List<int> _implicitFunctionTypeIndices;
  List<idl.EntityRef> _typeArguments;

  @override
  int get slot {
    _slot ??= const fb.Uint32Reader().vTableGet(_bp, 0, 0);
    return _slot;
  }

  @override
  int get reference {
    _reference ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _reference;
  }

  @override
  int get paramReference {
    _paramReference ??= const fb.Uint32Reader().vTableGet(_bp, 2, 0);
    return _paramReference;
  }

  @override
  List<int> get implicitFunctionTypeIndices {
    _implicitFunctionTypeIndices ??= const fb.ListReader<int>(const fb.Uint32Reader()).vTableGet(_bp, 3, const <int>[]);
    return _implicitFunctionTypeIndices;
  }

  @override
  List<idl.EntityRef> get typeArguments {
    _typeArguments ??= const fb.ListReader<idl.EntityRef>(const _EntityRefReader()).vTableGet(_bp, 4, const <idl.EntityRef>[]);
    return _typeArguments;
  }
}

abstract class _EntityRefMixin implements idl.EntityRef {
  @override
  Map<String, Object> toMap() => {
    "slot": slot,
    "reference": reference,
    "paramReference": paramReference,
    "implicitFunctionTypeIndices": implicitFunctionTypeIndices,
    "typeArguments": typeArguments,
  };
}

class LinkedDependencyBuilder extends Object with _LinkedDependencyMixin implements idl.LinkedDependency {
  bool _finished = false;

  String _uri;
  List<String> _parts;

  @override
  String get uri => _uri ??= '';

  /**
   * The relative URI of the dependent library.  This URI is relative to the
   * importing library, even if there are intervening `export` declarations.
   * So, for example, if `a.dart` imports `b/c.dart` and `b/c.dart` exports
   * `d/e.dart`, the URI listed for `a.dart`'s dependency on `e.dart` will be
   * `b/d/e.dart`.
   */
  void set uri(String _value) {
    assert(!_finished);
    _uri = _value;
  }

  @override
  List<String> get parts => _parts ??= <String>[];

  /**
   * URI for the compilation units listed in the library's `part` declarations.
   * These URIs are relative to the importing library.
   */
  void set parts(List<String> _value) {
    assert(!_finished);
    _parts = _value;
  }

  LinkedDependencyBuilder({String uri, List<String> parts})
    : _uri = uri,
      _parts = parts;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_uri;
    fb.Offset offset_parts;
    if (_uri != null) {
      offset_uri = fbBuilder.writeString(_uri);
    }
    if (!(_parts == null || _parts.isEmpty)) {
      offset_parts = fbBuilder.writeList(_parts.map((b) => fbBuilder.writeString(b)).toList());
    }
    fbBuilder.startTable();
    if (offset_uri != null) {
      fbBuilder.addOffset(0, offset_uri);
    }
    if (offset_parts != null) {
      fbBuilder.addOffset(1, offset_parts);
    }
    return fbBuilder.endTable();
  }
}

class _LinkedDependencyReader extends fb.TableReader<_LinkedDependencyImpl> {
  const _LinkedDependencyReader();

  @override
  _LinkedDependencyImpl createObject(fb.BufferPointer bp) => new _LinkedDependencyImpl(bp);
}

class _LinkedDependencyImpl extends Object with _LinkedDependencyMixin implements idl.LinkedDependency {
  final fb.BufferPointer _bp;

  _LinkedDependencyImpl(this._bp);

  String _uri;
  List<String> _parts;

  @override
  String get uri {
    _uri ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _uri;
  }

  @override
  List<String> get parts {
    _parts ??= const fb.ListReader<String>(const fb.StringReader()).vTableGet(_bp, 1, const <String>[]);
    return _parts;
  }
}

abstract class _LinkedDependencyMixin implements idl.LinkedDependency {
  @override
  Map<String, Object> toMap() => {
    "uri": uri,
    "parts": parts,
  };
}

class LinkedExportNameBuilder extends Object with _LinkedExportNameMixin implements idl.LinkedExportName {
  bool _finished = false;

  String _name;
  int _dependency;
  int _unit;
  idl.ReferenceKind _kind;

  @override
  String get name => _name ??= '';

  /**
   * Name of the exported entity.  For an exported setter, this name includes
   * the trailing '='.
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  int get dependency => _dependency ??= 0;

  /**
   * Index into [LinkedLibrary.dependencies] for the library in which the
   * entity is defined.
   */
  void set dependency(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _dependency = _value;
  }

  @override
  int get unit => _unit ??= 0;

  /**
   * Integer index indicating which unit in the exported library contains the
   * definition of the entity.  As with indices into [LinkedLibrary.units],
   * zero represents the defining compilation unit, and nonzero values
   * represent parts in the order of the corresponding `part` declarations.
   */
  void set unit(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _unit = _value;
  }

  @override
  idl.ReferenceKind get kind => _kind ??= idl.ReferenceKind.classOrEnum;

  /**
   * The kind of the entity being referred to.
   */
  void set kind(idl.ReferenceKind _value) {
    assert(!_finished);
    _kind = _value;
  }

  LinkedExportNameBuilder({String name, int dependency, int unit, idl.ReferenceKind kind})
    : _name = name,
      _dependency = dependency,
      _unit = unit,
      _kind = kind;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    fbBuilder.startTable();
    if (offset_name != null) {
      fbBuilder.addOffset(0, offset_name);
    }
    if (_dependency != null && _dependency != 0) {
      fbBuilder.addUint32(1, _dependency);
    }
    if (_unit != null && _unit != 0) {
      fbBuilder.addUint32(2, _unit);
    }
    if (_kind != null && _kind != idl.ReferenceKind.classOrEnum) {
      fbBuilder.addUint32(3, _kind.index);
    }
    return fbBuilder.endTable();
  }
}

class _LinkedExportNameReader extends fb.TableReader<_LinkedExportNameImpl> {
  const _LinkedExportNameReader();

  @override
  _LinkedExportNameImpl createObject(fb.BufferPointer bp) => new _LinkedExportNameImpl(bp);
}

class _LinkedExportNameImpl extends Object with _LinkedExportNameMixin implements idl.LinkedExportName {
  final fb.BufferPointer _bp;

  _LinkedExportNameImpl(this._bp);

  String _name;
  int _dependency;
  int _unit;
  idl.ReferenceKind _kind;

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _name;
  }

  @override
  int get dependency {
    _dependency ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _dependency;
  }

  @override
  int get unit {
    _unit ??= const fb.Uint32Reader().vTableGet(_bp, 2, 0);
    return _unit;
  }

  @override
  idl.ReferenceKind get kind {
    _kind ??= const _ReferenceKindReader().vTableGet(_bp, 3, idl.ReferenceKind.classOrEnum);
    return _kind;
  }
}

abstract class _LinkedExportNameMixin implements idl.LinkedExportName {
  @override
  Map<String, Object> toMap() => {
    "name": name,
    "dependency": dependency,
    "unit": unit,
    "kind": kind,
  };
}

class LinkedLibraryBuilder extends Object with _LinkedLibraryMixin implements idl.LinkedLibrary {
  bool _finished = false;

  List<LinkedUnitBuilder> _units;
  List<LinkedDependencyBuilder> _dependencies;
  List<int> _importDependencies;
  List<LinkedExportNameBuilder> _exportNames;
  int _numPrelinkedDependencies;

  @override
  List<LinkedUnitBuilder> get units => _units ??= <LinkedUnitBuilder>[];

  /**
   * The linked summary of all the compilation units constituting the
   * library.  The summary of the defining compilation unit is listed first,
   * followed by the summary of each part, in the order of the `part`
   * declarations in the defining compilation unit.
   */
  void set units(List<LinkedUnitBuilder> _value) {
    assert(!_finished);
    _units = _value;
  }

  @override
  List<LinkedDependencyBuilder> get dependencies => _dependencies ??= <LinkedDependencyBuilder>[];

  /**
   * The libraries that this library depends on (either via an explicit import
   * statement or via the implicit dependencies on `dart:core` and
   * `dart:async`).  The first element of this array is a pseudo-dependency
   * representing the library itself (it is also used for `dynamic` and
   * `void`).  This is followed by elements representing "prelinked"
   * dependencies (direct imports and the transitive closure of exports).
   * After the prelinked dependencies are elements representing "linked"
   * dependencies.
   *
   * A library is only included as a "linked" dependency if it is a true
   * dependency (e.g. a propagated or inferred type or constant value
   * implicitly refers to an element declared in the library) or
   * anti-dependency (e.g. the result of type propagation or type inference
   * depends on the lack of a certain declaration in the library).
   */
  void set dependencies(List<LinkedDependencyBuilder> _value) {
    assert(!_finished);
    _dependencies = _value;
  }

  @override
  List<int> get importDependencies => _importDependencies ??= <int>[];

  /**
   * For each import in [UnlinkedUnit.imports], an index into [dependencies]
   * of the library being imported.
   */
  void set importDependencies(List<int> _value) {
    assert(!_finished);
    assert(_value == null || _value.every((e) => e >= 0));
    _importDependencies = _value;
  }

  @override
  List<LinkedExportNameBuilder> get exportNames => _exportNames ??= <LinkedExportNameBuilder>[];

  /**
   * Information about entities in the export namespace of the library that are
   * not in the public namespace of the library (that is, entities that are
   * brought into the namespace via `export` directives).
   *
   * Sorted by name.
   */
  void set exportNames(List<LinkedExportNameBuilder> _value) {
    assert(!_finished);
    _exportNames = _value;
  }

  @override
  int get numPrelinkedDependencies => _numPrelinkedDependencies ??= 0;

  /**
   * The number of elements in [dependencies] which are not "linked"
   * dependencies (that is, the number of libraries in the direct imports plus
   * the transitive closure of exports, plus the library itself).
   */
  void set numPrelinkedDependencies(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _numPrelinkedDependencies = _value;
  }

  LinkedLibraryBuilder({List<LinkedUnitBuilder> units, List<LinkedDependencyBuilder> dependencies, List<int> importDependencies, List<LinkedExportNameBuilder> exportNames, int numPrelinkedDependencies})
    : _units = units,
      _dependencies = dependencies,
      _importDependencies = importDependencies,
      _exportNames = exportNames,
      _numPrelinkedDependencies = numPrelinkedDependencies;

  List<int> toBuffer() {
    fb.Builder fbBuilder = new fb.Builder();
    return fbBuilder.finish(finish(fbBuilder));
  }

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_units;
    fb.Offset offset_dependencies;
    fb.Offset offset_importDependencies;
    fb.Offset offset_exportNames;
    if (!(_units == null || _units.isEmpty)) {
      offset_units = fbBuilder.writeList(_units.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_dependencies == null || _dependencies.isEmpty)) {
      offset_dependencies = fbBuilder.writeList(_dependencies.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_importDependencies == null || _importDependencies.isEmpty)) {
      offset_importDependencies = fbBuilder.writeListUint32(_importDependencies);
    }
    if (!(_exportNames == null || _exportNames.isEmpty)) {
      offset_exportNames = fbBuilder.writeList(_exportNames.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_units != null) {
      fbBuilder.addOffset(0, offset_units);
    }
    if (offset_dependencies != null) {
      fbBuilder.addOffset(1, offset_dependencies);
    }
    if (offset_importDependencies != null) {
      fbBuilder.addOffset(2, offset_importDependencies);
    }
    if (offset_exportNames != null) {
      fbBuilder.addOffset(3, offset_exportNames);
    }
    if (_numPrelinkedDependencies != null && _numPrelinkedDependencies != 0) {
      fbBuilder.addUint32(4, _numPrelinkedDependencies);
    }
    return fbBuilder.endTable();
  }
}

idl.LinkedLibrary readLinkedLibrary(List<int> buffer) {
  fb.BufferPointer rootRef = new fb.BufferPointer.fromBytes(buffer);
  return const _LinkedLibraryReader().read(rootRef);
}

class _LinkedLibraryReader extends fb.TableReader<_LinkedLibraryImpl> {
  const _LinkedLibraryReader();

  @override
  _LinkedLibraryImpl createObject(fb.BufferPointer bp) => new _LinkedLibraryImpl(bp);
}

class _LinkedLibraryImpl extends Object with _LinkedLibraryMixin implements idl.LinkedLibrary {
  final fb.BufferPointer _bp;

  _LinkedLibraryImpl(this._bp);

  List<idl.LinkedUnit> _units;
  List<idl.LinkedDependency> _dependencies;
  List<int> _importDependencies;
  List<idl.LinkedExportName> _exportNames;
  int _numPrelinkedDependencies;

  @override
  List<idl.LinkedUnit> get units {
    _units ??= const fb.ListReader<idl.LinkedUnit>(const _LinkedUnitReader()).vTableGet(_bp, 0, const <idl.LinkedUnit>[]);
    return _units;
  }

  @override
  List<idl.LinkedDependency> get dependencies {
    _dependencies ??= const fb.ListReader<idl.LinkedDependency>(const _LinkedDependencyReader()).vTableGet(_bp, 1, const <idl.LinkedDependency>[]);
    return _dependencies;
  }

  @override
  List<int> get importDependencies {
    _importDependencies ??= const fb.ListReader<int>(const fb.Uint32Reader()).vTableGet(_bp, 2, const <int>[]);
    return _importDependencies;
  }

  @override
  List<idl.LinkedExportName> get exportNames {
    _exportNames ??= const fb.ListReader<idl.LinkedExportName>(const _LinkedExportNameReader()).vTableGet(_bp, 3, const <idl.LinkedExportName>[]);
    return _exportNames;
  }

  @override
  int get numPrelinkedDependencies {
    _numPrelinkedDependencies ??= const fb.Uint32Reader().vTableGet(_bp, 4, 0);
    return _numPrelinkedDependencies;
  }
}

abstract class _LinkedLibraryMixin implements idl.LinkedLibrary {
  @override
  Map<String, Object> toMap() => {
    "units": units,
    "dependencies": dependencies,
    "importDependencies": importDependencies,
    "exportNames": exportNames,
    "numPrelinkedDependencies": numPrelinkedDependencies,
  };
}

class LinkedReferenceBuilder extends Object with _LinkedReferenceMixin implements idl.LinkedReference {
  bool _finished = false;

  int _dependency;
  idl.ReferenceKind _kind;
  int _unit;
  int _numTypeParameters;
  String _name;
  int _containingReference;

  @override
  int get dependency => _dependency ??= 0;

  /**
   * Index into [LinkedLibrary.dependencies] indicating which imported library
   * declares the entity being referred to.
   *
   * Zero if this entity is contained within another entity (e.g. a class
   * member), or if [kind] is [ReferenceKind.prefix].
   */
  void set dependency(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _dependency = _value;
  }

  @override
  idl.ReferenceKind get kind => _kind ??= idl.ReferenceKind.classOrEnum;

  /**
   * The kind of the entity being referred to.  For the pseudo-types `dynamic`
   * and `void`, the kind is [ReferenceKind.classOrEnum].
   */
  void set kind(idl.ReferenceKind _value) {
    assert(!_finished);
    _kind = _value;
  }

  @override
  int get unit => _unit ??= 0;

  /**
   * Integer index indicating which unit in the imported library contains the
   * definition of the entity.  As with indices into [LinkedLibrary.units],
   * zero represents the defining compilation unit, and nonzero values
   * represent parts in the order of the corresponding `part` declarations.
   *
   * Zero if this entity is contained within another entity (e.g. a class
   * member).
   */
  void set unit(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _unit = _value;
  }

  @override
  int get numTypeParameters => _numTypeParameters ??= 0;

  /**
   * If the entity being referred to is generic, the number of type parameters
   * it accepts.  Otherwise zero.
   */
  void set numTypeParameters(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _numTypeParameters = _value;
  }

  @override
  String get name => _name ??= '';

  /**
   * If this [LinkedReference] doesn't have an associated [UnlinkedReference],
   * name of the entity being referred to.  For the pseudo-type `dynamic`, the
   * string is "dynamic".  For the pseudo-type `void`, the string is "void".
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  int get containingReference => _containingReference ??= 0;

  /**
   * If this [LinkedReference] doesn't have an associated [UnlinkedReference],
   * and the entity being referred to is contained within another entity, index
   * of the containing entity.  This behaves similarly to
   * [UnlinkedReference.prefixReference], however it is only used for class
   * members, not for prefixed imports.
   *
   * Containing references must always point backward; that is, for all i, if
   * LinkedUnit.references[i].containingReference != 0, then
   * LinkedUnit.references[i].containingReference < i.
   */
  void set containingReference(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _containingReference = _value;
  }

  LinkedReferenceBuilder({int dependency, idl.ReferenceKind kind, int unit, int numTypeParameters, String name, int containingReference})
    : _dependency = dependency,
      _kind = kind,
      _unit = unit,
      _numTypeParameters = numTypeParameters,
      _name = name,
      _containingReference = containingReference;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    fbBuilder.startTable();
    if (_dependency != null && _dependency != 0) {
      fbBuilder.addUint32(0, _dependency);
    }
    if (_kind != null && _kind != idl.ReferenceKind.classOrEnum) {
      fbBuilder.addUint32(1, _kind.index);
    }
    if (_unit != null && _unit != 0) {
      fbBuilder.addUint32(2, _unit);
    }
    if (_numTypeParameters != null && _numTypeParameters != 0) {
      fbBuilder.addUint32(3, _numTypeParameters);
    }
    if (offset_name != null) {
      fbBuilder.addOffset(4, offset_name);
    }
    if (_containingReference != null && _containingReference != 0) {
      fbBuilder.addUint32(5, _containingReference);
    }
    return fbBuilder.endTable();
  }
}

class _LinkedReferenceReader extends fb.TableReader<_LinkedReferenceImpl> {
  const _LinkedReferenceReader();

  @override
  _LinkedReferenceImpl createObject(fb.BufferPointer bp) => new _LinkedReferenceImpl(bp);
}

class _LinkedReferenceImpl extends Object with _LinkedReferenceMixin implements idl.LinkedReference {
  final fb.BufferPointer _bp;

  _LinkedReferenceImpl(this._bp);

  int _dependency;
  idl.ReferenceKind _kind;
  int _unit;
  int _numTypeParameters;
  String _name;
  int _containingReference;

  @override
  int get dependency {
    _dependency ??= const fb.Uint32Reader().vTableGet(_bp, 0, 0);
    return _dependency;
  }

  @override
  idl.ReferenceKind get kind {
    _kind ??= const _ReferenceKindReader().vTableGet(_bp, 1, idl.ReferenceKind.classOrEnum);
    return _kind;
  }

  @override
  int get unit {
    _unit ??= const fb.Uint32Reader().vTableGet(_bp, 2, 0);
    return _unit;
  }

  @override
  int get numTypeParameters {
    _numTypeParameters ??= const fb.Uint32Reader().vTableGet(_bp, 3, 0);
    return _numTypeParameters;
  }

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 4, '');
    return _name;
  }

  @override
  int get containingReference {
    _containingReference ??= const fb.Uint32Reader().vTableGet(_bp, 5, 0);
    return _containingReference;
  }
}

abstract class _LinkedReferenceMixin implements idl.LinkedReference {
  @override
  Map<String, Object> toMap() => {
    "dependency": dependency,
    "kind": kind,
    "unit": unit,
    "numTypeParameters": numTypeParameters,
    "name": name,
    "containingReference": containingReference,
  };
}

class LinkedUnitBuilder extends Object with _LinkedUnitMixin implements idl.LinkedUnit {
  bool _finished = false;

  List<LinkedReferenceBuilder> _references;
  List<EntityRefBuilder> _types;

  @override
  List<LinkedReferenceBuilder> get references => _references ??= <LinkedReferenceBuilder>[];

  /**
   * Information about the resolution of references within the compilation
   * unit.  Each element of [UnlinkedUnit.references] has a corresponding
   * element in this list (at the same index).  If this list has additional
   * elements beyond the number of elements in [UnlinkedUnit.references], those
   * additional elements are references that are only referred to implicitly
   * (e.g. elements involved in inferred or propagated types).
   */
  void set references(List<LinkedReferenceBuilder> _value) {
    assert(!_finished);
    _references = _value;
  }

  @override
  List<EntityRefBuilder> get types => _types ??= <EntityRefBuilder>[];

  /**
   * List associating slot ids found inside the unlinked summary for the
   * compilation unit with propagated and inferred types.
   */
  void set types(List<EntityRefBuilder> _value) {
    assert(!_finished);
    _types = _value;
  }

  LinkedUnitBuilder({List<LinkedReferenceBuilder> references, List<EntityRefBuilder> types})
    : _references = references,
      _types = types;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_references;
    fb.Offset offset_types;
    if (!(_references == null || _references.isEmpty)) {
      offset_references = fbBuilder.writeList(_references.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_types == null || _types.isEmpty)) {
      offset_types = fbBuilder.writeList(_types.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_references != null) {
      fbBuilder.addOffset(0, offset_references);
    }
    if (offset_types != null) {
      fbBuilder.addOffset(1, offset_types);
    }
    return fbBuilder.endTable();
  }
}

class _LinkedUnitReader extends fb.TableReader<_LinkedUnitImpl> {
  const _LinkedUnitReader();

  @override
  _LinkedUnitImpl createObject(fb.BufferPointer bp) => new _LinkedUnitImpl(bp);
}

class _LinkedUnitImpl extends Object with _LinkedUnitMixin implements idl.LinkedUnit {
  final fb.BufferPointer _bp;

  _LinkedUnitImpl(this._bp);

  List<idl.LinkedReference> _references;
  List<idl.EntityRef> _types;

  @override
  List<idl.LinkedReference> get references {
    _references ??= const fb.ListReader<idl.LinkedReference>(const _LinkedReferenceReader()).vTableGet(_bp, 0, const <idl.LinkedReference>[]);
    return _references;
  }

  @override
  List<idl.EntityRef> get types {
    _types ??= const fb.ListReader<idl.EntityRef>(const _EntityRefReader()).vTableGet(_bp, 1, const <idl.EntityRef>[]);
    return _types;
  }
}

abstract class _LinkedUnitMixin implements idl.LinkedUnit {
  @override
  Map<String, Object> toMap() => {
    "references": references,
    "types": types,
  };
}

class SdkBundleBuilder extends Object with _SdkBundleMixin implements idl.SdkBundle {
  bool _finished = false;

  List<String> _linkedLibraryUris;
  List<LinkedLibraryBuilder> _linkedLibraries;
  List<String> _unlinkedUnitUris;
  List<UnlinkedUnitBuilder> _unlinkedUnits;

  @override
  List<String> get linkedLibraryUris => _linkedLibraryUris ??= <String>[];

  /**
   * The list of URIs of items in [linkedLibraries], e.g. `dart:core`.
   */
  void set linkedLibraryUris(List<String> _value) {
    assert(!_finished);
    _linkedLibraryUris = _value;
  }

  @override
  List<LinkedLibraryBuilder> get linkedLibraries => _linkedLibraries ??= <LinkedLibraryBuilder>[];

  /**
   * Linked libraries.
   */
  void set linkedLibraries(List<LinkedLibraryBuilder> _value) {
    assert(!_finished);
    _linkedLibraries = _value;
  }

  @override
  List<String> get unlinkedUnitUris => _unlinkedUnitUris ??= <String>[];

  /**
   * The list of URIs of items in [unlinkedUnits], e.g. `dart:core/bool.dart`.
   */
  void set unlinkedUnitUris(List<String> _value) {
    assert(!_finished);
    _unlinkedUnitUris = _value;
  }

  @override
  List<UnlinkedUnitBuilder> get unlinkedUnits => _unlinkedUnits ??= <UnlinkedUnitBuilder>[];

  /**
   * Unlinked information for the compilation units constituting the SDK.
   */
  void set unlinkedUnits(List<UnlinkedUnitBuilder> _value) {
    assert(!_finished);
    _unlinkedUnits = _value;
  }

  SdkBundleBuilder({List<String> linkedLibraryUris, List<LinkedLibraryBuilder> linkedLibraries, List<String> unlinkedUnitUris, List<UnlinkedUnitBuilder> unlinkedUnits})
    : _linkedLibraryUris = linkedLibraryUris,
      _linkedLibraries = linkedLibraries,
      _unlinkedUnitUris = unlinkedUnitUris,
      _unlinkedUnits = unlinkedUnits;

  List<int> toBuffer() {
    fb.Builder fbBuilder = new fb.Builder();
    return fbBuilder.finish(finish(fbBuilder));
  }

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_linkedLibraryUris;
    fb.Offset offset_linkedLibraries;
    fb.Offset offset_unlinkedUnitUris;
    fb.Offset offset_unlinkedUnits;
    if (!(_linkedLibraryUris == null || _linkedLibraryUris.isEmpty)) {
      offset_linkedLibraryUris = fbBuilder.writeList(_linkedLibraryUris.map((b) => fbBuilder.writeString(b)).toList());
    }
    if (!(_linkedLibraries == null || _linkedLibraries.isEmpty)) {
      offset_linkedLibraries = fbBuilder.writeList(_linkedLibraries.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_unlinkedUnitUris == null || _unlinkedUnitUris.isEmpty)) {
      offset_unlinkedUnitUris = fbBuilder.writeList(_unlinkedUnitUris.map((b) => fbBuilder.writeString(b)).toList());
    }
    if (!(_unlinkedUnits == null || _unlinkedUnits.isEmpty)) {
      offset_unlinkedUnits = fbBuilder.writeList(_unlinkedUnits.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_linkedLibraryUris != null) {
      fbBuilder.addOffset(0, offset_linkedLibraryUris);
    }
    if (offset_linkedLibraries != null) {
      fbBuilder.addOffset(1, offset_linkedLibraries);
    }
    if (offset_unlinkedUnitUris != null) {
      fbBuilder.addOffset(2, offset_unlinkedUnitUris);
    }
    if (offset_unlinkedUnits != null) {
      fbBuilder.addOffset(3, offset_unlinkedUnits);
    }
    return fbBuilder.endTable();
  }
}

idl.SdkBundle readSdkBundle(List<int> buffer) {
  fb.BufferPointer rootRef = new fb.BufferPointer.fromBytes(buffer);
  return const _SdkBundleReader().read(rootRef);
}

class _SdkBundleReader extends fb.TableReader<_SdkBundleImpl> {
  const _SdkBundleReader();

  @override
  _SdkBundleImpl createObject(fb.BufferPointer bp) => new _SdkBundleImpl(bp);
}

class _SdkBundleImpl extends Object with _SdkBundleMixin implements idl.SdkBundle {
  final fb.BufferPointer _bp;

  _SdkBundleImpl(this._bp);

  List<String> _linkedLibraryUris;
  List<idl.LinkedLibrary> _linkedLibraries;
  List<String> _unlinkedUnitUris;
  List<idl.UnlinkedUnit> _unlinkedUnits;

  @override
  List<String> get linkedLibraryUris {
    _linkedLibraryUris ??= const fb.ListReader<String>(const fb.StringReader()).vTableGet(_bp, 0, const <String>[]);
    return _linkedLibraryUris;
  }

  @override
  List<idl.LinkedLibrary> get linkedLibraries {
    _linkedLibraries ??= const fb.ListReader<idl.LinkedLibrary>(const _LinkedLibraryReader()).vTableGet(_bp, 1, const <idl.LinkedLibrary>[]);
    return _linkedLibraries;
  }

  @override
  List<String> get unlinkedUnitUris {
    _unlinkedUnitUris ??= const fb.ListReader<String>(const fb.StringReader()).vTableGet(_bp, 2, const <String>[]);
    return _unlinkedUnitUris;
  }

  @override
  List<idl.UnlinkedUnit> get unlinkedUnits {
    _unlinkedUnits ??= const fb.ListReader<idl.UnlinkedUnit>(const _UnlinkedUnitReader()).vTableGet(_bp, 3, const <idl.UnlinkedUnit>[]);
    return _unlinkedUnits;
  }
}

abstract class _SdkBundleMixin implements idl.SdkBundle {
  @override
  Map<String, Object> toMap() => {
    "linkedLibraryUris": linkedLibraryUris,
    "linkedLibraries": linkedLibraries,
    "unlinkedUnitUris": unlinkedUnitUris,
    "unlinkedUnits": unlinkedUnits,
  };
}

class UnlinkedClassBuilder extends Object with _UnlinkedClassMixin implements idl.UnlinkedClass {
  bool _finished = false;

  String _name;
  int _nameOffset;
  UnlinkedDocumentationCommentBuilder _documentationComment;
  List<UnlinkedTypeParamBuilder> _typeParameters;
  EntityRefBuilder _supertype;
  List<EntityRefBuilder> _mixins;
  List<EntityRefBuilder> _interfaces;
  List<UnlinkedVariableBuilder> _fields;
  List<UnlinkedExecutableBuilder> _executables;
  bool _isAbstract;
  bool _isMixinApplication;
  bool _hasNoSupertype;

  @override
  String get name => _name ??= '';

  /**
   * Name of the class.
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  int get nameOffset => _nameOffset ??= 0;

  /**
   * Offset of the class name relative to the beginning of the file.
   */
  void set nameOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _nameOffset = _value;
  }

  @override
  UnlinkedDocumentationCommentBuilder get documentationComment => _documentationComment;

  /**
   * Documentation comment for the class, or `null` if there is no
   * documentation comment.
   */
  void set documentationComment(UnlinkedDocumentationCommentBuilder _value) {
    assert(!_finished);
    _documentationComment = _value;
  }

  @override
  List<UnlinkedTypeParamBuilder> get typeParameters => _typeParameters ??= <UnlinkedTypeParamBuilder>[];

  /**
   * Type parameters of the class, if any.
   */
  void set typeParameters(List<UnlinkedTypeParamBuilder> _value) {
    assert(!_finished);
    _typeParameters = _value;
  }

  @override
  EntityRefBuilder get supertype => _supertype;

  /**
   * Supertype of the class, or `null` if either (a) the class doesn't
   * explicitly declare a supertype (and hence has supertype `Object`), or (b)
   * the class *is* `Object` (and hence has no supertype).
   */
  void set supertype(EntityRefBuilder _value) {
    assert(!_finished);
    _supertype = _value;
  }

  @override
  List<EntityRefBuilder> get mixins => _mixins ??= <EntityRefBuilder>[];

  /**
   * Mixins appearing in a `with` clause, if any.
   */
  void set mixins(List<EntityRefBuilder> _value) {
    assert(!_finished);
    _mixins = _value;
  }

  @override
  List<EntityRefBuilder> get interfaces => _interfaces ??= <EntityRefBuilder>[];

  /**
   * Interfaces appearing in an `implements` clause, if any.
   */
  void set interfaces(List<EntityRefBuilder> _value) {
    assert(!_finished);
    _interfaces = _value;
  }

  @override
  List<UnlinkedVariableBuilder> get fields => _fields ??= <UnlinkedVariableBuilder>[];

  /**
   * Field declarations contained in the class.
   */
  void set fields(List<UnlinkedVariableBuilder> _value) {
    assert(!_finished);
    _fields = _value;
  }

  @override
  List<UnlinkedExecutableBuilder> get executables => _executables ??= <UnlinkedExecutableBuilder>[];

  /**
   * Executable objects (methods, getters, and setters) contained in the class.
   */
  void set executables(List<UnlinkedExecutableBuilder> _value) {
    assert(!_finished);
    _executables = _value;
  }

  @override
  bool get isAbstract => _isAbstract ??= false;

  /**
   * Indicates whether the class is declared with the `abstract` keyword.
   */
  void set isAbstract(bool _value) {
    assert(!_finished);
    _isAbstract = _value;
  }

  @override
  bool get isMixinApplication => _isMixinApplication ??= false;

  /**
   * Indicates whether the class is declared using mixin application syntax.
   */
  void set isMixinApplication(bool _value) {
    assert(!_finished);
    _isMixinApplication = _value;
  }

  @override
  bool get hasNoSupertype => _hasNoSupertype ??= false;

  /**
   * Indicates whether this class is the core "Object" class (and hence has no
   * supertype)
   */
  void set hasNoSupertype(bool _value) {
    assert(!_finished);
    _hasNoSupertype = _value;
  }

  UnlinkedClassBuilder({String name, int nameOffset, UnlinkedDocumentationCommentBuilder documentationComment, List<UnlinkedTypeParamBuilder> typeParameters, EntityRefBuilder supertype, List<EntityRefBuilder> mixins, List<EntityRefBuilder> interfaces, List<UnlinkedVariableBuilder> fields, List<UnlinkedExecutableBuilder> executables, bool isAbstract, bool isMixinApplication, bool hasNoSupertype})
    : _name = name,
      _nameOffset = nameOffset,
      _documentationComment = documentationComment,
      _typeParameters = typeParameters,
      _supertype = supertype,
      _mixins = mixins,
      _interfaces = interfaces,
      _fields = fields,
      _executables = executables,
      _isAbstract = isAbstract,
      _isMixinApplication = isMixinApplication,
      _hasNoSupertype = hasNoSupertype;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    fb.Offset offset_documentationComment;
    fb.Offset offset_typeParameters;
    fb.Offset offset_supertype;
    fb.Offset offset_mixins;
    fb.Offset offset_interfaces;
    fb.Offset offset_fields;
    fb.Offset offset_executables;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    if (_documentationComment != null) {
      offset_documentationComment = _documentationComment.finish(fbBuilder);
    }
    if (!(_typeParameters == null || _typeParameters.isEmpty)) {
      offset_typeParameters = fbBuilder.writeList(_typeParameters.map((b) => b.finish(fbBuilder)).toList());
    }
    if (_supertype != null) {
      offset_supertype = _supertype.finish(fbBuilder);
    }
    if (!(_mixins == null || _mixins.isEmpty)) {
      offset_mixins = fbBuilder.writeList(_mixins.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_interfaces == null || _interfaces.isEmpty)) {
      offset_interfaces = fbBuilder.writeList(_interfaces.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_fields == null || _fields.isEmpty)) {
      offset_fields = fbBuilder.writeList(_fields.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_executables == null || _executables.isEmpty)) {
      offset_executables = fbBuilder.writeList(_executables.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_name != null) {
      fbBuilder.addOffset(0, offset_name);
    }
    if (_nameOffset != null && _nameOffset != 0) {
      fbBuilder.addUint32(1, _nameOffset);
    }
    if (offset_documentationComment != null) {
      fbBuilder.addOffset(2, offset_documentationComment);
    }
    if (offset_typeParameters != null) {
      fbBuilder.addOffset(3, offset_typeParameters);
    }
    if (offset_supertype != null) {
      fbBuilder.addOffset(4, offset_supertype);
    }
    if (offset_mixins != null) {
      fbBuilder.addOffset(5, offset_mixins);
    }
    if (offset_interfaces != null) {
      fbBuilder.addOffset(6, offset_interfaces);
    }
    if (offset_fields != null) {
      fbBuilder.addOffset(7, offset_fields);
    }
    if (offset_executables != null) {
      fbBuilder.addOffset(8, offset_executables);
    }
    if (_isAbstract == true) {
      fbBuilder.addBool(9, true);
    }
    if (_isMixinApplication == true) {
      fbBuilder.addBool(10, true);
    }
    if (_hasNoSupertype == true) {
      fbBuilder.addBool(11, true);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedClassReader extends fb.TableReader<_UnlinkedClassImpl> {
  const _UnlinkedClassReader();

  @override
  _UnlinkedClassImpl createObject(fb.BufferPointer bp) => new _UnlinkedClassImpl(bp);
}

class _UnlinkedClassImpl extends Object with _UnlinkedClassMixin implements idl.UnlinkedClass {
  final fb.BufferPointer _bp;

  _UnlinkedClassImpl(this._bp);

  String _name;
  int _nameOffset;
  idl.UnlinkedDocumentationComment _documentationComment;
  List<idl.UnlinkedTypeParam> _typeParameters;
  idl.EntityRef _supertype;
  List<idl.EntityRef> _mixins;
  List<idl.EntityRef> _interfaces;
  List<idl.UnlinkedVariable> _fields;
  List<idl.UnlinkedExecutable> _executables;
  bool _isAbstract;
  bool _isMixinApplication;
  bool _hasNoSupertype;

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _name;
  }

  @override
  int get nameOffset {
    _nameOffset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _nameOffset;
  }

  @override
  idl.UnlinkedDocumentationComment get documentationComment {
    _documentationComment ??= const _UnlinkedDocumentationCommentReader().vTableGet(_bp, 2, null);
    return _documentationComment;
  }

  @override
  List<idl.UnlinkedTypeParam> get typeParameters {
    _typeParameters ??= const fb.ListReader<idl.UnlinkedTypeParam>(const _UnlinkedTypeParamReader()).vTableGet(_bp, 3, const <idl.UnlinkedTypeParam>[]);
    return _typeParameters;
  }

  @override
  idl.EntityRef get supertype {
    _supertype ??= const _EntityRefReader().vTableGet(_bp, 4, null);
    return _supertype;
  }

  @override
  List<idl.EntityRef> get mixins {
    _mixins ??= const fb.ListReader<idl.EntityRef>(const _EntityRefReader()).vTableGet(_bp, 5, const <idl.EntityRef>[]);
    return _mixins;
  }

  @override
  List<idl.EntityRef> get interfaces {
    _interfaces ??= const fb.ListReader<idl.EntityRef>(const _EntityRefReader()).vTableGet(_bp, 6, const <idl.EntityRef>[]);
    return _interfaces;
  }

  @override
  List<idl.UnlinkedVariable> get fields {
    _fields ??= const fb.ListReader<idl.UnlinkedVariable>(const _UnlinkedVariableReader()).vTableGet(_bp, 7, const <idl.UnlinkedVariable>[]);
    return _fields;
  }

  @override
  List<idl.UnlinkedExecutable> get executables {
    _executables ??= const fb.ListReader<idl.UnlinkedExecutable>(const _UnlinkedExecutableReader()).vTableGet(_bp, 8, const <idl.UnlinkedExecutable>[]);
    return _executables;
  }

  @override
  bool get isAbstract {
    _isAbstract ??= const fb.BoolReader().vTableGet(_bp, 9, false);
    return _isAbstract;
  }

  @override
  bool get isMixinApplication {
    _isMixinApplication ??= const fb.BoolReader().vTableGet(_bp, 10, false);
    return _isMixinApplication;
  }

  @override
  bool get hasNoSupertype {
    _hasNoSupertype ??= const fb.BoolReader().vTableGet(_bp, 11, false);
    return _hasNoSupertype;
  }
}

abstract class _UnlinkedClassMixin implements idl.UnlinkedClass {
  @override
  Map<String, Object> toMap() => {
    "name": name,
    "nameOffset": nameOffset,
    "documentationComment": documentationComment,
    "typeParameters": typeParameters,
    "supertype": supertype,
    "mixins": mixins,
    "interfaces": interfaces,
    "fields": fields,
    "executables": executables,
    "isAbstract": isAbstract,
    "isMixinApplication": isMixinApplication,
    "hasNoSupertype": hasNoSupertype,
  };
}

class UnlinkedCombinatorBuilder extends Object with _UnlinkedCombinatorMixin implements idl.UnlinkedCombinator {
  bool _finished = false;

  List<String> _shows;
  List<String> _hides;

  @override
  List<String> get shows => _shows ??= <String>[];

  /**
   * List of names which are shown.  Empty if this is a `hide` combinator.
   */
  void set shows(List<String> _value) {
    assert(!_finished);
    _shows = _value;
  }

  @override
  List<String> get hides => _hides ??= <String>[];

  /**
   * List of names which are hidden.  Empty if this is a `show` combinator.
   */
  void set hides(List<String> _value) {
    assert(!_finished);
    _hides = _value;
  }

  UnlinkedCombinatorBuilder({List<String> shows, List<String> hides})
    : _shows = shows,
      _hides = hides;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_shows;
    fb.Offset offset_hides;
    if (!(_shows == null || _shows.isEmpty)) {
      offset_shows = fbBuilder.writeList(_shows.map((b) => fbBuilder.writeString(b)).toList());
    }
    if (!(_hides == null || _hides.isEmpty)) {
      offset_hides = fbBuilder.writeList(_hides.map((b) => fbBuilder.writeString(b)).toList());
    }
    fbBuilder.startTable();
    if (offset_shows != null) {
      fbBuilder.addOffset(0, offset_shows);
    }
    if (offset_hides != null) {
      fbBuilder.addOffset(1, offset_hides);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedCombinatorReader extends fb.TableReader<_UnlinkedCombinatorImpl> {
  const _UnlinkedCombinatorReader();

  @override
  _UnlinkedCombinatorImpl createObject(fb.BufferPointer bp) => new _UnlinkedCombinatorImpl(bp);
}

class _UnlinkedCombinatorImpl extends Object with _UnlinkedCombinatorMixin implements idl.UnlinkedCombinator {
  final fb.BufferPointer _bp;

  _UnlinkedCombinatorImpl(this._bp);

  List<String> _shows;
  List<String> _hides;

  @override
  List<String> get shows {
    _shows ??= const fb.ListReader<String>(const fb.StringReader()).vTableGet(_bp, 0, const <String>[]);
    return _shows;
  }

  @override
  List<String> get hides {
    _hides ??= const fb.ListReader<String>(const fb.StringReader()).vTableGet(_bp, 1, const <String>[]);
    return _hides;
  }
}

abstract class _UnlinkedCombinatorMixin implements idl.UnlinkedCombinator {
  @override
  Map<String, Object> toMap() => {
    "shows": shows,
    "hides": hides,
  };
}

class UnlinkedConstBuilder extends Object with _UnlinkedConstMixin implements idl.UnlinkedConst {
  bool _finished = false;

  List<idl.UnlinkedConstOperation> _operations;
  List<int> _ints;
  List<double> _doubles;
  List<String> _strings;
  List<EntityRefBuilder> _references;

  @override
  List<idl.UnlinkedConstOperation> get operations => _operations ??= <idl.UnlinkedConstOperation>[];

  /**
   * Sequence of operations to execute (starting with an empty stack) to form
   * the constant value.
   */
  void set operations(List<idl.UnlinkedConstOperation> _value) {
    assert(!_finished);
    _operations = _value;
  }

  @override
  List<int> get ints => _ints ??= <int>[];

  /**
   * Sequence of unsigned 32-bit integers consumed by the operations
   * `pushArgument`, `pushInt`, `shiftOr`, `concatenate`, `invokeConstructor`,
   * `makeList`, and `makeMap`.
   */
  void set ints(List<int> _value) {
    assert(!_finished);
    assert(_value == null || _value.every((e) => e >= 0));
    _ints = _value;
  }

  @override
  List<double> get doubles => _doubles ??= <double>[];

  /**
   * Sequence of 64-bit doubles consumed by the operation `pushDouble`.
   */
  void set doubles(List<double> _value) {
    assert(!_finished);
    _doubles = _value;
  }

  @override
  List<String> get strings => _strings ??= <String>[];

  /**
   * Sequence of strings consumed by the operations `pushString` and
   * `invokeConstructor`.
   */
  void set strings(List<String> _value) {
    assert(!_finished);
    _strings = _value;
  }

  @override
  List<EntityRefBuilder> get references => _references ??= <EntityRefBuilder>[];

  /**
   * Sequence of language constructs consumed by the operations
   * `pushReference`, `invokeConstructor`, `makeList`, and `makeMap`.  Note
   * that in the case of `pushReference` (and sometimes `invokeConstructor` the
   * actual entity being referred to may be something other than a type.
   */
  void set references(List<EntityRefBuilder> _value) {
    assert(!_finished);
    _references = _value;
  }

  UnlinkedConstBuilder({List<idl.UnlinkedConstOperation> operations, List<int> ints, List<double> doubles, List<String> strings, List<EntityRefBuilder> references})
    : _operations = operations,
      _ints = ints,
      _doubles = doubles,
      _strings = strings,
      _references = references;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_operations;
    fb.Offset offset_ints;
    fb.Offset offset_doubles;
    fb.Offset offset_strings;
    fb.Offset offset_references;
    if (!(_operations == null || _operations.isEmpty)) {
      offset_operations = fbBuilder.writeListUint32(_operations.map((b) => b.index).toList());
    }
    if (!(_ints == null || _ints.isEmpty)) {
      offset_ints = fbBuilder.writeListUint32(_ints);
    }
    if (!(_doubles == null || _doubles.isEmpty)) {
      offset_doubles = fbBuilder.writeListFloat64(_doubles);
    }
    if (!(_strings == null || _strings.isEmpty)) {
      offset_strings = fbBuilder.writeList(_strings.map((b) => fbBuilder.writeString(b)).toList());
    }
    if (!(_references == null || _references.isEmpty)) {
      offset_references = fbBuilder.writeList(_references.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_operations != null) {
      fbBuilder.addOffset(0, offset_operations);
    }
    if (offset_ints != null) {
      fbBuilder.addOffset(1, offset_ints);
    }
    if (offset_doubles != null) {
      fbBuilder.addOffset(2, offset_doubles);
    }
    if (offset_strings != null) {
      fbBuilder.addOffset(3, offset_strings);
    }
    if (offset_references != null) {
      fbBuilder.addOffset(4, offset_references);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedConstReader extends fb.TableReader<_UnlinkedConstImpl> {
  const _UnlinkedConstReader();

  @override
  _UnlinkedConstImpl createObject(fb.BufferPointer bp) => new _UnlinkedConstImpl(bp);
}

class _UnlinkedConstImpl extends Object with _UnlinkedConstMixin implements idl.UnlinkedConst {
  final fb.BufferPointer _bp;

  _UnlinkedConstImpl(this._bp);

  List<idl.UnlinkedConstOperation> _operations;
  List<int> _ints;
  List<double> _doubles;
  List<String> _strings;
  List<idl.EntityRef> _references;

  @override
  List<idl.UnlinkedConstOperation> get operations {
    _operations ??= const fb.ListReader<idl.UnlinkedConstOperation>(const _UnlinkedConstOperationReader()).vTableGet(_bp, 0, const <idl.UnlinkedConstOperation>[]);
    return _operations;
  }

  @override
  List<int> get ints {
    _ints ??= const fb.ListReader<int>(const fb.Uint32Reader()).vTableGet(_bp, 1, const <int>[]);
    return _ints;
  }

  @override
  List<double> get doubles {
    _doubles ??= const fb.Float64ListReader().vTableGet(_bp, 2, const <double>[]);
    return _doubles;
  }

  @override
  List<String> get strings {
    _strings ??= const fb.ListReader<String>(const fb.StringReader()).vTableGet(_bp, 3, const <String>[]);
    return _strings;
  }

  @override
  List<idl.EntityRef> get references {
    _references ??= const fb.ListReader<idl.EntityRef>(const _EntityRefReader()).vTableGet(_bp, 4, const <idl.EntityRef>[]);
    return _references;
  }
}

abstract class _UnlinkedConstMixin implements idl.UnlinkedConst {
  @override
  Map<String, Object> toMap() => {
    "operations": operations,
    "ints": ints,
    "doubles": doubles,
    "strings": strings,
    "references": references,
  };
}

class UnlinkedDocumentationCommentBuilder extends Object with _UnlinkedDocumentationCommentMixin implements idl.UnlinkedDocumentationComment {
  bool _finished = false;

  String _text;
  int _offset;
  int _length;

  @override
  String get text => _text ??= '';

  /**
   * Text of the documentation comment, with '\r\n' replaced by '\n'.
   *
   * References appearing within the doc comment in square brackets are not
   * specially encoded.
   */
  void set text(String _value) {
    assert(!_finished);
    _text = _value;
  }

  @override
  int get offset => _offset ??= 0;

  /**
   * Offset of the beginning of the documentation comment relative to the
   * beginning of the file.
   */
  void set offset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _offset = _value;
  }

  @override
  int get length => _length ??= 0;

  /**
   * Length of the documentation comment (prior to replacing '\r\n' with '\n').
   */
  void set length(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _length = _value;
  }

  UnlinkedDocumentationCommentBuilder({String text, int offset, int length})
    : _text = text,
      _offset = offset,
      _length = length;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_text;
    if (_text != null) {
      offset_text = fbBuilder.writeString(_text);
    }
    fbBuilder.startTable();
    if (offset_text != null) {
      fbBuilder.addOffset(0, offset_text);
    }
    if (_offset != null && _offset != 0) {
      fbBuilder.addUint32(1, _offset);
    }
    if (_length != null && _length != 0) {
      fbBuilder.addUint32(2, _length);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedDocumentationCommentReader extends fb.TableReader<_UnlinkedDocumentationCommentImpl> {
  const _UnlinkedDocumentationCommentReader();

  @override
  _UnlinkedDocumentationCommentImpl createObject(fb.BufferPointer bp) => new _UnlinkedDocumentationCommentImpl(bp);
}

class _UnlinkedDocumentationCommentImpl extends Object with _UnlinkedDocumentationCommentMixin implements idl.UnlinkedDocumentationComment {
  final fb.BufferPointer _bp;

  _UnlinkedDocumentationCommentImpl(this._bp);

  String _text;
  int _offset;
  int _length;

  @override
  String get text {
    _text ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _text;
  }

  @override
  int get offset {
    _offset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _offset;
  }

  @override
  int get length {
    _length ??= const fb.Uint32Reader().vTableGet(_bp, 2, 0);
    return _length;
  }
}

abstract class _UnlinkedDocumentationCommentMixin implements idl.UnlinkedDocumentationComment {
  @override
  Map<String, Object> toMap() => {
    "text": text,
    "offset": offset,
    "length": length,
  };
}

class UnlinkedEnumBuilder extends Object with _UnlinkedEnumMixin implements idl.UnlinkedEnum {
  bool _finished = false;

  String _name;
  int _nameOffset;
  UnlinkedDocumentationCommentBuilder _documentationComment;
  List<UnlinkedEnumValueBuilder> _values;

  @override
  String get name => _name ??= '';

  /**
   * Name of the enum type.
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  int get nameOffset => _nameOffset ??= 0;

  /**
   * Offset of the enum name relative to the beginning of the file.
   */
  void set nameOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _nameOffset = _value;
  }

  @override
  UnlinkedDocumentationCommentBuilder get documentationComment => _documentationComment;

  /**
   * Documentation comment for the enum, or `null` if there is no documentation
   * comment.
   */
  void set documentationComment(UnlinkedDocumentationCommentBuilder _value) {
    assert(!_finished);
    _documentationComment = _value;
  }

  @override
  List<UnlinkedEnumValueBuilder> get values => _values ??= <UnlinkedEnumValueBuilder>[];

  /**
   * Values listed in the enum declaration, in declaration order.
   */
  void set values(List<UnlinkedEnumValueBuilder> _value) {
    assert(!_finished);
    _values = _value;
  }

  UnlinkedEnumBuilder({String name, int nameOffset, UnlinkedDocumentationCommentBuilder documentationComment, List<UnlinkedEnumValueBuilder> values})
    : _name = name,
      _nameOffset = nameOffset,
      _documentationComment = documentationComment,
      _values = values;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    fb.Offset offset_documentationComment;
    fb.Offset offset_values;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    if (_documentationComment != null) {
      offset_documentationComment = _documentationComment.finish(fbBuilder);
    }
    if (!(_values == null || _values.isEmpty)) {
      offset_values = fbBuilder.writeList(_values.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_name != null) {
      fbBuilder.addOffset(0, offset_name);
    }
    if (_nameOffset != null && _nameOffset != 0) {
      fbBuilder.addUint32(1, _nameOffset);
    }
    if (offset_documentationComment != null) {
      fbBuilder.addOffset(2, offset_documentationComment);
    }
    if (offset_values != null) {
      fbBuilder.addOffset(3, offset_values);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedEnumReader extends fb.TableReader<_UnlinkedEnumImpl> {
  const _UnlinkedEnumReader();

  @override
  _UnlinkedEnumImpl createObject(fb.BufferPointer bp) => new _UnlinkedEnumImpl(bp);
}

class _UnlinkedEnumImpl extends Object with _UnlinkedEnumMixin implements idl.UnlinkedEnum {
  final fb.BufferPointer _bp;

  _UnlinkedEnumImpl(this._bp);

  String _name;
  int _nameOffset;
  idl.UnlinkedDocumentationComment _documentationComment;
  List<idl.UnlinkedEnumValue> _values;

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _name;
  }

  @override
  int get nameOffset {
    _nameOffset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _nameOffset;
  }

  @override
  idl.UnlinkedDocumentationComment get documentationComment {
    _documentationComment ??= const _UnlinkedDocumentationCommentReader().vTableGet(_bp, 2, null);
    return _documentationComment;
  }

  @override
  List<idl.UnlinkedEnumValue> get values {
    _values ??= const fb.ListReader<idl.UnlinkedEnumValue>(const _UnlinkedEnumValueReader()).vTableGet(_bp, 3, const <idl.UnlinkedEnumValue>[]);
    return _values;
  }
}

abstract class _UnlinkedEnumMixin implements idl.UnlinkedEnum {
  @override
  Map<String, Object> toMap() => {
    "name": name,
    "nameOffset": nameOffset,
    "documentationComment": documentationComment,
    "values": values,
  };
}

class UnlinkedEnumValueBuilder extends Object with _UnlinkedEnumValueMixin implements idl.UnlinkedEnumValue {
  bool _finished = false;

  String _name;
  int _nameOffset;
  UnlinkedDocumentationCommentBuilder _documentationComment;

  @override
  String get name => _name ??= '';

  /**
   * Name of the enumerated value.
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  int get nameOffset => _nameOffset ??= 0;

  /**
   * Offset of the enum value name relative to the beginning of the file.
   */
  void set nameOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _nameOffset = _value;
  }

  @override
  UnlinkedDocumentationCommentBuilder get documentationComment => _documentationComment;

  /**
   * Documentation comment for the enum value, or `null` if there is no
   * documentation comment.
   */
  void set documentationComment(UnlinkedDocumentationCommentBuilder _value) {
    assert(!_finished);
    _documentationComment = _value;
  }

  UnlinkedEnumValueBuilder({String name, int nameOffset, UnlinkedDocumentationCommentBuilder documentationComment})
    : _name = name,
      _nameOffset = nameOffset,
      _documentationComment = documentationComment;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    fb.Offset offset_documentationComment;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    if (_documentationComment != null) {
      offset_documentationComment = _documentationComment.finish(fbBuilder);
    }
    fbBuilder.startTable();
    if (offset_name != null) {
      fbBuilder.addOffset(0, offset_name);
    }
    if (_nameOffset != null && _nameOffset != 0) {
      fbBuilder.addUint32(1, _nameOffset);
    }
    if (offset_documentationComment != null) {
      fbBuilder.addOffset(2, offset_documentationComment);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedEnumValueReader extends fb.TableReader<_UnlinkedEnumValueImpl> {
  const _UnlinkedEnumValueReader();

  @override
  _UnlinkedEnumValueImpl createObject(fb.BufferPointer bp) => new _UnlinkedEnumValueImpl(bp);
}

class _UnlinkedEnumValueImpl extends Object with _UnlinkedEnumValueMixin implements idl.UnlinkedEnumValue {
  final fb.BufferPointer _bp;

  _UnlinkedEnumValueImpl(this._bp);

  String _name;
  int _nameOffset;
  idl.UnlinkedDocumentationComment _documentationComment;

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _name;
  }

  @override
  int get nameOffset {
    _nameOffset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _nameOffset;
  }

  @override
  idl.UnlinkedDocumentationComment get documentationComment {
    _documentationComment ??= const _UnlinkedDocumentationCommentReader().vTableGet(_bp, 2, null);
    return _documentationComment;
  }
}

abstract class _UnlinkedEnumValueMixin implements idl.UnlinkedEnumValue {
  @override
  Map<String, Object> toMap() => {
    "name": name,
    "nameOffset": nameOffset,
    "documentationComment": documentationComment,
  };
}

class UnlinkedExecutableBuilder extends Object with _UnlinkedExecutableMixin implements idl.UnlinkedExecutable {
  bool _finished = false;

  String _name;
  int _nameOffset;
  UnlinkedDocumentationCommentBuilder _documentationComment;
  List<UnlinkedTypeParamBuilder> _typeParameters;
  EntityRefBuilder _returnType;
  List<UnlinkedParamBuilder> _parameters;
  idl.UnlinkedExecutableKind _kind;
  bool _isAbstract;
  bool _isStatic;
  bool _isConst;
  bool _isFactory;
  bool _isExternal;
  int _inferredReturnTypeSlot;

  @override
  String get name => _name ??= '';

  /**
   * Name of the executable.  For setters, this includes the trailing "=".  For
   * named constructors, this excludes the class name and excludes the ".".
   * For unnamed constructors, this is the empty string.
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  int get nameOffset => _nameOffset ??= 0;

  /**
   * Offset of the executable name relative to the beginning of the file.  For
   * named constructors, this excludes the class name and excludes the ".".
   * For unnamed constructors, this is the offset of the class name (i.e. the
   * offset of the second "C" in "class C { C(); }").
   */
  void set nameOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _nameOffset = _value;
  }

  @override
  UnlinkedDocumentationCommentBuilder get documentationComment => _documentationComment;

  /**
   * Documentation comment for the executable, or `null` if there is no
   * documentation comment.
   */
  void set documentationComment(UnlinkedDocumentationCommentBuilder _value) {
    assert(!_finished);
    _documentationComment = _value;
  }

  @override
  List<UnlinkedTypeParamBuilder> get typeParameters => _typeParameters ??= <UnlinkedTypeParamBuilder>[];

  /**
   * Type parameters of the executable, if any.  Empty if support for generic
   * method syntax is disabled.
   */
  void set typeParameters(List<UnlinkedTypeParamBuilder> _value) {
    assert(!_finished);
    _typeParameters = _value;
  }

  @override
  EntityRefBuilder get returnType => _returnType;

  /**
   * Declared return type of the executable.  Absent if the executable is a
   * constructor or the return type is implicit.
   */
  void set returnType(EntityRefBuilder _value) {
    assert(!_finished);
    _returnType = _value;
  }

  @override
  List<UnlinkedParamBuilder> get parameters => _parameters ??= <UnlinkedParamBuilder>[];

  /**
   * Parameters of the executable, if any.  Note that getters have no
   * parameters (hence this will be the empty list), and setters have a single
   * parameter.
   */
  void set parameters(List<UnlinkedParamBuilder> _value) {
    assert(!_finished);
    _parameters = _value;
  }

  @override
  idl.UnlinkedExecutableKind get kind => _kind ??= idl.UnlinkedExecutableKind.functionOrMethod;

  /**
   * The kind of the executable (function/method, getter, setter, or
   * constructor).
   */
  void set kind(idl.UnlinkedExecutableKind _value) {
    assert(!_finished);
    _kind = _value;
  }

  @override
  bool get isAbstract => _isAbstract ??= false;

  /**
   * Indicates whether the executable is declared using the `abstract` keyword.
   */
  void set isAbstract(bool _value) {
    assert(!_finished);
    _isAbstract = _value;
  }

  @override
  bool get isStatic => _isStatic ??= false;

  /**
   * Indicates whether the executable is declared using the `static` keyword.
   *
   * Note that for top level executables, this flag is false, since they are
   * not declared using the `static` keyword (even though they are considered
   * static for semantic purposes).
   */
  void set isStatic(bool _value) {
    assert(!_finished);
    _isStatic = _value;
  }

  @override
  bool get isConst => _isConst ??= false;

  /**
   * Indicates whether the executable is declared using the `const` keyword.
   */
  void set isConst(bool _value) {
    assert(!_finished);
    _isConst = _value;
  }

  @override
  bool get isFactory => _isFactory ??= false;

  /**
   * Indicates whether the executable is declared using the `factory` keyword.
   */
  void set isFactory(bool _value) {
    assert(!_finished);
    _isFactory = _value;
  }

  @override
  bool get isExternal => _isExternal ??= false;

  /**
   * Indicates whether the executable is declared using the `external` keyword.
   */
  void set isExternal(bool _value) {
    assert(!_finished);
    _isExternal = _value;
  }

  @override
  int get inferredReturnTypeSlot => _inferredReturnTypeSlot ??= 0;

  /**
   * If this executable's return type is inferable, nonzero slot id
   * identifying which entry in [LinkedLibrary.types] contains the inferred
   * return type.  If there is no matching entry in [LinkedLibrary.types], then
   * no return type was inferred for this variable, so its static type is
   * `dynamic`.
   */
  void set inferredReturnTypeSlot(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _inferredReturnTypeSlot = _value;
  }

  UnlinkedExecutableBuilder({String name, int nameOffset, UnlinkedDocumentationCommentBuilder documentationComment, List<UnlinkedTypeParamBuilder> typeParameters, EntityRefBuilder returnType, List<UnlinkedParamBuilder> parameters, idl.UnlinkedExecutableKind kind, bool isAbstract, bool isStatic, bool isConst, bool isFactory, bool isExternal, int inferredReturnTypeSlot})
    : _name = name,
      _nameOffset = nameOffset,
      _documentationComment = documentationComment,
      _typeParameters = typeParameters,
      _returnType = returnType,
      _parameters = parameters,
      _kind = kind,
      _isAbstract = isAbstract,
      _isStatic = isStatic,
      _isConst = isConst,
      _isFactory = isFactory,
      _isExternal = isExternal,
      _inferredReturnTypeSlot = inferredReturnTypeSlot;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    fb.Offset offset_documentationComment;
    fb.Offset offset_typeParameters;
    fb.Offset offset_returnType;
    fb.Offset offset_parameters;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    if (_documentationComment != null) {
      offset_documentationComment = _documentationComment.finish(fbBuilder);
    }
    if (!(_typeParameters == null || _typeParameters.isEmpty)) {
      offset_typeParameters = fbBuilder.writeList(_typeParameters.map((b) => b.finish(fbBuilder)).toList());
    }
    if (_returnType != null) {
      offset_returnType = _returnType.finish(fbBuilder);
    }
    if (!(_parameters == null || _parameters.isEmpty)) {
      offset_parameters = fbBuilder.writeList(_parameters.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_name != null) {
      fbBuilder.addOffset(0, offset_name);
    }
    if (_nameOffset != null && _nameOffset != 0) {
      fbBuilder.addUint32(1, _nameOffset);
    }
    if (offset_documentationComment != null) {
      fbBuilder.addOffset(2, offset_documentationComment);
    }
    if (offset_typeParameters != null) {
      fbBuilder.addOffset(3, offset_typeParameters);
    }
    if (offset_returnType != null) {
      fbBuilder.addOffset(4, offset_returnType);
    }
    if (offset_parameters != null) {
      fbBuilder.addOffset(5, offset_parameters);
    }
    if (_kind != null && _kind != idl.UnlinkedExecutableKind.functionOrMethod) {
      fbBuilder.addUint32(6, _kind.index);
    }
    if (_isAbstract == true) {
      fbBuilder.addBool(7, true);
    }
    if (_isStatic == true) {
      fbBuilder.addBool(8, true);
    }
    if (_isConst == true) {
      fbBuilder.addBool(9, true);
    }
    if (_isFactory == true) {
      fbBuilder.addBool(10, true);
    }
    if (_isExternal == true) {
      fbBuilder.addBool(11, true);
    }
    if (_inferredReturnTypeSlot != null && _inferredReturnTypeSlot != 0) {
      fbBuilder.addUint32(12, _inferredReturnTypeSlot);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedExecutableReader extends fb.TableReader<_UnlinkedExecutableImpl> {
  const _UnlinkedExecutableReader();

  @override
  _UnlinkedExecutableImpl createObject(fb.BufferPointer bp) => new _UnlinkedExecutableImpl(bp);
}

class _UnlinkedExecutableImpl extends Object with _UnlinkedExecutableMixin implements idl.UnlinkedExecutable {
  final fb.BufferPointer _bp;

  _UnlinkedExecutableImpl(this._bp);

  String _name;
  int _nameOffset;
  idl.UnlinkedDocumentationComment _documentationComment;
  List<idl.UnlinkedTypeParam> _typeParameters;
  idl.EntityRef _returnType;
  List<idl.UnlinkedParam> _parameters;
  idl.UnlinkedExecutableKind _kind;
  bool _isAbstract;
  bool _isStatic;
  bool _isConst;
  bool _isFactory;
  bool _isExternal;
  int _inferredReturnTypeSlot;

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _name;
  }

  @override
  int get nameOffset {
    _nameOffset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _nameOffset;
  }

  @override
  idl.UnlinkedDocumentationComment get documentationComment {
    _documentationComment ??= const _UnlinkedDocumentationCommentReader().vTableGet(_bp, 2, null);
    return _documentationComment;
  }

  @override
  List<idl.UnlinkedTypeParam> get typeParameters {
    _typeParameters ??= const fb.ListReader<idl.UnlinkedTypeParam>(const _UnlinkedTypeParamReader()).vTableGet(_bp, 3, const <idl.UnlinkedTypeParam>[]);
    return _typeParameters;
  }

  @override
  idl.EntityRef get returnType {
    _returnType ??= const _EntityRefReader().vTableGet(_bp, 4, null);
    return _returnType;
  }

  @override
  List<idl.UnlinkedParam> get parameters {
    _parameters ??= const fb.ListReader<idl.UnlinkedParam>(const _UnlinkedParamReader()).vTableGet(_bp, 5, const <idl.UnlinkedParam>[]);
    return _parameters;
  }

  @override
  idl.UnlinkedExecutableKind get kind {
    _kind ??= const _UnlinkedExecutableKindReader().vTableGet(_bp, 6, idl.UnlinkedExecutableKind.functionOrMethod);
    return _kind;
  }

  @override
  bool get isAbstract {
    _isAbstract ??= const fb.BoolReader().vTableGet(_bp, 7, false);
    return _isAbstract;
  }

  @override
  bool get isStatic {
    _isStatic ??= const fb.BoolReader().vTableGet(_bp, 8, false);
    return _isStatic;
  }

  @override
  bool get isConst {
    _isConst ??= const fb.BoolReader().vTableGet(_bp, 9, false);
    return _isConst;
  }

  @override
  bool get isFactory {
    _isFactory ??= const fb.BoolReader().vTableGet(_bp, 10, false);
    return _isFactory;
  }

  @override
  bool get isExternal {
    _isExternal ??= const fb.BoolReader().vTableGet(_bp, 11, false);
    return _isExternal;
  }

  @override
  int get inferredReturnTypeSlot {
    _inferredReturnTypeSlot ??= const fb.Uint32Reader().vTableGet(_bp, 12, 0);
    return _inferredReturnTypeSlot;
  }
}

abstract class _UnlinkedExecutableMixin implements idl.UnlinkedExecutable {
  @override
  Map<String, Object> toMap() => {
    "name": name,
    "nameOffset": nameOffset,
    "documentationComment": documentationComment,
    "typeParameters": typeParameters,
    "returnType": returnType,
    "parameters": parameters,
    "kind": kind,
    "isAbstract": isAbstract,
    "isStatic": isStatic,
    "isConst": isConst,
    "isFactory": isFactory,
    "isExternal": isExternal,
    "inferredReturnTypeSlot": inferredReturnTypeSlot,
  };
}

class UnlinkedExportNonPublicBuilder extends Object with _UnlinkedExportNonPublicMixin implements idl.UnlinkedExportNonPublic {
  bool _finished = false;

  int _offset;
  int _uriOffset;
  int _uriEnd;

  @override
  int get offset => _offset ??= 0;

  /**
   * Offset of the "export" keyword.
   */
  void set offset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _offset = _value;
  }

  @override
  int get uriOffset => _uriOffset ??= 0;

  /**
   * Offset of the URI string (including quotes) relative to the beginning of
   * the file.
   */
  void set uriOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _uriOffset = _value;
  }

  @override
  int get uriEnd => _uriEnd ??= 0;

  /**
   * End of the URI string (including quotes) relative to the beginning of the
   * file.
   */
  void set uriEnd(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _uriEnd = _value;
  }

  UnlinkedExportNonPublicBuilder({int offset, int uriOffset, int uriEnd})
    : _offset = offset,
      _uriOffset = uriOffset,
      _uriEnd = uriEnd;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fbBuilder.startTable();
    if (_offset != null && _offset != 0) {
      fbBuilder.addUint32(0, _offset);
    }
    if (_uriOffset != null && _uriOffset != 0) {
      fbBuilder.addUint32(1, _uriOffset);
    }
    if (_uriEnd != null && _uriEnd != 0) {
      fbBuilder.addUint32(2, _uriEnd);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedExportNonPublicReader extends fb.TableReader<_UnlinkedExportNonPublicImpl> {
  const _UnlinkedExportNonPublicReader();

  @override
  _UnlinkedExportNonPublicImpl createObject(fb.BufferPointer bp) => new _UnlinkedExportNonPublicImpl(bp);
}

class _UnlinkedExportNonPublicImpl extends Object with _UnlinkedExportNonPublicMixin implements idl.UnlinkedExportNonPublic {
  final fb.BufferPointer _bp;

  _UnlinkedExportNonPublicImpl(this._bp);

  int _offset;
  int _uriOffset;
  int _uriEnd;

  @override
  int get offset {
    _offset ??= const fb.Uint32Reader().vTableGet(_bp, 0, 0);
    return _offset;
  }

  @override
  int get uriOffset {
    _uriOffset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _uriOffset;
  }

  @override
  int get uriEnd {
    _uriEnd ??= const fb.Uint32Reader().vTableGet(_bp, 2, 0);
    return _uriEnd;
  }
}

abstract class _UnlinkedExportNonPublicMixin implements idl.UnlinkedExportNonPublic {
  @override
  Map<String, Object> toMap() => {
    "offset": offset,
    "uriOffset": uriOffset,
    "uriEnd": uriEnd,
  };
}

class UnlinkedExportPublicBuilder extends Object with _UnlinkedExportPublicMixin implements idl.UnlinkedExportPublic {
  bool _finished = false;

  String _uri;
  List<UnlinkedCombinatorBuilder> _combinators;

  @override
  String get uri => _uri ??= '';

  /**
   * URI used in the source code to reference the exported library.
   */
  void set uri(String _value) {
    assert(!_finished);
    _uri = _value;
  }

  @override
  List<UnlinkedCombinatorBuilder> get combinators => _combinators ??= <UnlinkedCombinatorBuilder>[];

  /**
   * Combinators contained in this import declaration.
   */
  void set combinators(List<UnlinkedCombinatorBuilder> _value) {
    assert(!_finished);
    _combinators = _value;
  }

  UnlinkedExportPublicBuilder({String uri, List<UnlinkedCombinatorBuilder> combinators})
    : _uri = uri,
      _combinators = combinators;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_uri;
    fb.Offset offset_combinators;
    if (_uri != null) {
      offset_uri = fbBuilder.writeString(_uri);
    }
    if (!(_combinators == null || _combinators.isEmpty)) {
      offset_combinators = fbBuilder.writeList(_combinators.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_uri != null) {
      fbBuilder.addOffset(0, offset_uri);
    }
    if (offset_combinators != null) {
      fbBuilder.addOffset(1, offset_combinators);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedExportPublicReader extends fb.TableReader<_UnlinkedExportPublicImpl> {
  const _UnlinkedExportPublicReader();

  @override
  _UnlinkedExportPublicImpl createObject(fb.BufferPointer bp) => new _UnlinkedExportPublicImpl(bp);
}

class _UnlinkedExportPublicImpl extends Object with _UnlinkedExportPublicMixin implements idl.UnlinkedExportPublic {
  final fb.BufferPointer _bp;

  _UnlinkedExportPublicImpl(this._bp);

  String _uri;
  List<idl.UnlinkedCombinator> _combinators;

  @override
  String get uri {
    _uri ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _uri;
  }

  @override
  List<idl.UnlinkedCombinator> get combinators {
    _combinators ??= const fb.ListReader<idl.UnlinkedCombinator>(const _UnlinkedCombinatorReader()).vTableGet(_bp, 1, const <idl.UnlinkedCombinator>[]);
    return _combinators;
  }
}

abstract class _UnlinkedExportPublicMixin implements idl.UnlinkedExportPublic {
  @override
  Map<String, Object> toMap() => {
    "uri": uri,
    "combinators": combinators,
  };
}

class UnlinkedImportBuilder extends Object with _UnlinkedImportMixin implements idl.UnlinkedImport {
  bool _finished = false;

  String _uri;
  int _offset;
  int _prefixReference;
  List<UnlinkedCombinatorBuilder> _combinators;
  bool _isDeferred;
  bool _isImplicit;
  int _uriOffset;
  int _uriEnd;
  int _prefixOffset;

  @override
  String get uri => _uri ??= '';

  /**
   * URI used in the source code to reference the imported library.
   */
  void set uri(String _value) {
    assert(!_finished);
    _uri = _value;
  }

  @override
  int get offset => _offset ??= 0;

  /**
   * If [isImplicit] is false, offset of the "import" keyword.  If [isImplicit]
   * is true, zero.
   */
  void set offset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _offset = _value;
  }

  @override
  int get prefixReference => _prefixReference ??= 0;

  /**
   * Index into [UnlinkedUnit.references] of the prefix declared by this
   * import declaration, or zero if this import declaration declares no prefix.
   *
   * Note that multiple imports can declare the same prefix.
   */
  void set prefixReference(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _prefixReference = _value;
  }

  @override
  List<UnlinkedCombinatorBuilder> get combinators => _combinators ??= <UnlinkedCombinatorBuilder>[];

  /**
   * Combinators contained in this import declaration.
   */
  void set combinators(List<UnlinkedCombinatorBuilder> _value) {
    assert(!_finished);
    _combinators = _value;
  }

  @override
  bool get isDeferred => _isDeferred ??= false;

  /**
   * Indicates whether the import declaration uses the `deferred` keyword.
   */
  void set isDeferred(bool _value) {
    assert(!_finished);
    _isDeferred = _value;
  }

  @override
  bool get isImplicit => _isImplicit ??= false;

  /**
   * Indicates whether the import declaration is implicit.
   */
  void set isImplicit(bool _value) {
    assert(!_finished);
    _isImplicit = _value;
  }

  @override
  int get uriOffset => _uriOffset ??= 0;

  /**
   * Offset of the URI string (including quotes) relative to the beginning of
   * the file.  If [isImplicit] is true, zero.
   */
  void set uriOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _uriOffset = _value;
  }

  @override
  int get uriEnd => _uriEnd ??= 0;

  /**
   * End of the URI string (including quotes) relative to the beginning of the
   * file.  If [isImplicit] is true, zero.
   */
  void set uriEnd(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _uriEnd = _value;
  }

  @override
  int get prefixOffset => _prefixOffset ??= 0;

  /**
   * Offset of the prefix name relative to the beginning of the file, or zero
   * if there is no prefix.
   */
  void set prefixOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _prefixOffset = _value;
  }

  UnlinkedImportBuilder({String uri, int offset, int prefixReference, List<UnlinkedCombinatorBuilder> combinators, bool isDeferred, bool isImplicit, int uriOffset, int uriEnd, int prefixOffset})
    : _uri = uri,
      _offset = offset,
      _prefixReference = prefixReference,
      _combinators = combinators,
      _isDeferred = isDeferred,
      _isImplicit = isImplicit,
      _uriOffset = uriOffset,
      _uriEnd = uriEnd,
      _prefixOffset = prefixOffset;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_uri;
    fb.Offset offset_combinators;
    if (_uri != null) {
      offset_uri = fbBuilder.writeString(_uri);
    }
    if (!(_combinators == null || _combinators.isEmpty)) {
      offset_combinators = fbBuilder.writeList(_combinators.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_uri != null) {
      fbBuilder.addOffset(0, offset_uri);
    }
    if (_offset != null && _offset != 0) {
      fbBuilder.addUint32(1, _offset);
    }
    if (_prefixReference != null && _prefixReference != 0) {
      fbBuilder.addUint32(2, _prefixReference);
    }
    if (offset_combinators != null) {
      fbBuilder.addOffset(3, offset_combinators);
    }
    if (_isDeferred == true) {
      fbBuilder.addBool(4, true);
    }
    if (_isImplicit == true) {
      fbBuilder.addBool(5, true);
    }
    if (_uriOffset != null && _uriOffset != 0) {
      fbBuilder.addUint32(6, _uriOffset);
    }
    if (_uriEnd != null && _uriEnd != 0) {
      fbBuilder.addUint32(7, _uriEnd);
    }
    if (_prefixOffset != null && _prefixOffset != 0) {
      fbBuilder.addUint32(8, _prefixOffset);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedImportReader extends fb.TableReader<_UnlinkedImportImpl> {
  const _UnlinkedImportReader();

  @override
  _UnlinkedImportImpl createObject(fb.BufferPointer bp) => new _UnlinkedImportImpl(bp);
}

class _UnlinkedImportImpl extends Object with _UnlinkedImportMixin implements idl.UnlinkedImport {
  final fb.BufferPointer _bp;

  _UnlinkedImportImpl(this._bp);

  String _uri;
  int _offset;
  int _prefixReference;
  List<idl.UnlinkedCombinator> _combinators;
  bool _isDeferred;
  bool _isImplicit;
  int _uriOffset;
  int _uriEnd;
  int _prefixOffset;

  @override
  String get uri {
    _uri ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _uri;
  }

  @override
  int get offset {
    _offset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _offset;
  }

  @override
  int get prefixReference {
    _prefixReference ??= const fb.Uint32Reader().vTableGet(_bp, 2, 0);
    return _prefixReference;
  }

  @override
  List<idl.UnlinkedCombinator> get combinators {
    _combinators ??= const fb.ListReader<idl.UnlinkedCombinator>(const _UnlinkedCombinatorReader()).vTableGet(_bp, 3, const <idl.UnlinkedCombinator>[]);
    return _combinators;
  }

  @override
  bool get isDeferred {
    _isDeferred ??= const fb.BoolReader().vTableGet(_bp, 4, false);
    return _isDeferred;
  }

  @override
  bool get isImplicit {
    _isImplicit ??= const fb.BoolReader().vTableGet(_bp, 5, false);
    return _isImplicit;
  }

  @override
  int get uriOffset {
    _uriOffset ??= const fb.Uint32Reader().vTableGet(_bp, 6, 0);
    return _uriOffset;
  }

  @override
  int get uriEnd {
    _uriEnd ??= const fb.Uint32Reader().vTableGet(_bp, 7, 0);
    return _uriEnd;
  }

  @override
  int get prefixOffset {
    _prefixOffset ??= const fb.Uint32Reader().vTableGet(_bp, 8, 0);
    return _prefixOffset;
  }
}

abstract class _UnlinkedImportMixin implements idl.UnlinkedImport {
  @override
  Map<String, Object> toMap() => {
    "uri": uri,
    "offset": offset,
    "prefixReference": prefixReference,
    "combinators": combinators,
    "isDeferred": isDeferred,
    "isImplicit": isImplicit,
    "uriOffset": uriOffset,
    "uriEnd": uriEnd,
    "prefixOffset": prefixOffset,
  };
}

class UnlinkedParamBuilder extends Object with _UnlinkedParamMixin implements idl.UnlinkedParam {
  bool _finished = false;

  String _name;
  int _nameOffset;
  EntityRefBuilder _type;
  List<UnlinkedParamBuilder> _parameters;
  idl.UnlinkedParamKind _kind;
  bool _isFunctionTyped;
  bool _isInitializingFormal;
  int _inferredTypeSlot;
  UnlinkedConstBuilder _defaultValue;

  @override
  String get name => _name ??= '';

  /**
   * Name of the parameter.
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  int get nameOffset => _nameOffset ??= 0;

  /**
   * Offset of the parameter name relative to the beginning of the file.
   */
  void set nameOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _nameOffset = _value;
  }

  @override
  EntityRefBuilder get type => _type;

  /**
   * If [isFunctionTyped] is `true`, the declared return type.  If
   * [isFunctionTyped] is `false`, the declared type.  Absent if the type is
   * implicit.
   */
  void set type(EntityRefBuilder _value) {
    assert(!_finished);
    _type = _value;
  }

  @override
  List<UnlinkedParamBuilder> get parameters => _parameters ??= <UnlinkedParamBuilder>[];

  /**
   * If [isFunctionTyped] is `true`, the parameters of the function type.
   */
  void set parameters(List<UnlinkedParamBuilder> _value) {
    assert(!_finished);
    _parameters = _value;
  }

  @override
  idl.UnlinkedParamKind get kind => _kind ??= idl.UnlinkedParamKind.required;

  /**
   * Kind of the parameter.
   */
  void set kind(idl.UnlinkedParamKind _value) {
    assert(!_finished);
    _kind = _value;
  }

  @override
  bool get isFunctionTyped => _isFunctionTyped ??= false;

  /**
   * Indicates whether this is a function-typed parameter.
   */
  void set isFunctionTyped(bool _value) {
    assert(!_finished);
    _isFunctionTyped = _value;
  }

  @override
  bool get isInitializingFormal => _isInitializingFormal ??= false;

  /**
   * Indicates whether this is an initializing formal parameter (i.e. it is
   * declared using `this.` syntax).
   */
  void set isInitializingFormal(bool _value) {
    assert(!_finished);
    _isInitializingFormal = _value;
  }

  @override
  int get inferredTypeSlot => _inferredTypeSlot ??= 0;

  /**
   * If this parameter's type is inferable, nonzero slot id identifying which
   * entry in [LinkedLibrary.types] contains the inferred type.  If there is no
   * matching entry in [LinkedLibrary.types], then no type was inferred for
   * this variable, so its static type is `dynamic`.
   *
   * Note that although strong mode considers initializing formals to be
   * inferable, they are not marked as such in the summary; if their type is
   * not specified, they always inherit the static type of the corresponding
   * field.
   */
  void set inferredTypeSlot(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _inferredTypeSlot = _value;
  }

  @override
  UnlinkedConstBuilder get defaultValue => _defaultValue;

  /**
   * If the parameter has a default value the constant expression in the
   * default value.
   */
  void set defaultValue(UnlinkedConstBuilder _value) {
    assert(!_finished);
    _defaultValue = _value;
  }

  UnlinkedParamBuilder({String name, int nameOffset, EntityRefBuilder type, List<UnlinkedParamBuilder> parameters, idl.UnlinkedParamKind kind, bool isFunctionTyped, bool isInitializingFormal, int inferredTypeSlot, UnlinkedConstBuilder defaultValue})
    : _name = name,
      _nameOffset = nameOffset,
      _type = type,
      _parameters = parameters,
      _kind = kind,
      _isFunctionTyped = isFunctionTyped,
      _isInitializingFormal = isInitializingFormal,
      _inferredTypeSlot = inferredTypeSlot,
      _defaultValue = defaultValue;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    fb.Offset offset_type;
    fb.Offset offset_parameters;
    fb.Offset offset_defaultValue;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    if (_type != null) {
      offset_type = _type.finish(fbBuilder);
    }
    if (!(_parameters == null || _parameters.isEmpty)) {
      offset_parameters = fbBuilder.writeList(_parameters.map((b) => b.finish(fbBuilder)).toList());
    }
    if (_defaultValue != null) {
      offset_defaultValue = _defaultValue.finish(fbBuilder);
    }
    fbBuilder.startTable();
    if (offset_name != null) {
      fbBuilder.addOffset(0, offset_name);
    }
    if (_nameOffset != null && _nameOffset != 0) {
      fbBuilder.addUint32(1, _nameOffset);
    }
    if (offset_type != null) {
      fbBuilder.addOffset(2, offset_type);
    }
    if (offset_parameters != null) {
      fbBuilder.addOffset(3, offset_parameters);
    }
    if (_kind != null && _kind != idl.UnlinkedParamKind.required) {
      fbBuilder.addUint32(4, _kind.index);
    }
    if (_isFunctionTyped == true) {
      fbBuilder.addBool(5, true);
    }
    if (_isInitializingFormal == true) {
      fbBuilder.addBool(6, true);
    }
    if (_inferredTypeSlot != null && _inferredTypeSlot != 0) {
      fbBuilder.addUint32(7, _inferredTypeSlot);
    }
    if (offset_defaultValue != null) {
      fbBuilder.addOffset(8, offset_defaultValue);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedParamReader extends fb.TableReader<_UnlinkedParamImpl> {
  const _UnlinkedParamReader();

  @override
  _UnlinkedParamImpl createObject(fb.BufferPointer bp) => new _UnlinkedParamImpl(bp);
}

class _UnlinkedParamImpl extends Object with _UnlinkedParamMixin implements idl.UnlinkedParam {
  final fb.BufferPointer _bp;

  _UnlinkedParamImpl(this._bp);

  String _name;
  int _nameOffset;
  idl.EntityRef _type;
  List<idl.UnlinkedParam> _parameters;
  idl.UnlinkedParamKind _kind;
  bool _isFunctionTyped;
  bool _isInitializingFormal;
  int _inferredTypeSlot;
  idl.UnlinkedConst _defaultValue;

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _name;
  }

  @override
  int get nameOffset {
    _nameOffset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _nameOffset;
  }

  @override
  idl.EntityRef get type {
    _type ??= const _EntityRefReader().vTableGet(_bp, 2, null);
    return _type;
  }

  @override
  List<idl.UnlinkedParam> get parameters {
    _parameters ??= const fb.ListReader<idl.UnlinkedParam>(const _UnlinkedParamReader()).vTableGet(_bp, 3, const <idl.UnlinkedParam>[]);
    return _parameters;
  }

  @override
  idl.UnlinkedParamKind get kind {
    _kind ??= const _UnlinkedParamKindReader().vTableGet(_bp, 4, idl.UnlinkedParamKind.required);
    return _kind;
  }

  @override
  bool get isFunctionTyped {
    _isFunctionTyped ??= const fb.BoolReader().vTableGet(_bp, 5, false);
    return _isFunctionTyped;
  }

  @override
  bool get isInitializingFormal {
    _isInitializingFormal ??= const fb.BoolReader().vTableGet(_bp, 6, false);
    return _isInitializingFormal;
  }

  @override
  int get inferredTypeSlot {
    _inferredTypeSlot ??= const fb.Uint32Reader().vTableGet(_bp, 7, 0);
    return _inferredTypeSlot;
  }

  @override
  idl.UnlinkedConst get defaultValue {
    _defaultValue ??= const _UnlinkedConstReader().vTableGet(_bp, 8, null);
    return _defaultValue;
  }
}

abstract class _UnlinkedParamMixin implements idl.UnlinkedParam {
  @override
  Map<String, Object> toMap() => {
    "name": name,
    "nameOffset": nameOffset,
    "type": type,
    "parameters": parameters,
    "kind": kind,
    "isFunctionTyped": isFunctionTyped,
    "isInitializingFormal": isInitializingFormal,
    "inferredTypeSlot": inferredTypeSlot,
    "defaultValue": defaultValue,
  };
}

class UnlinkedPartBuilder extends Object with _UnlinkedPartMixin implements idl.UnlinkedPart {
  bool _finished = false;

  int _uriOffset;
  int _uriEnd;

  @override
  int get uriOffset => _uriOffset ??= 0;

  /**
   * Offset of the URI string (including quotes) relative to the beginning of
   * the file.
   */
  void set uriOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _uriOffset = _value;
  }

  @override
  int get uriEnd => _uriEnd ??= 0;

  /**
   * End of the URI string (including quotes) relative to the beginning of the
   * file.
   */
  void set uriEnd(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _uriEnd = _value;
  }

  UnlinkedPartBuilder({int uriOffset, int uriEnd})
    : _uriOffset = uriOffset,
      _uriEnd = uriEnd;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fbBuilder.startTable();
    if (_uriOffset != null && _uriOffset != 0) {
      fbBuilder.addUint32(0, _uriOffset);
    }
    if (_uriEnd != null && _uriEnd != 0) {
      fbBuilder.addUint32(1, _uriEnd);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedPartReader extends fb.TableReader<_UnlinkedPartImpl> {
  const _UnlinkedPartReader();

  @override
  _UnlinkedPartImpl createObject(fb.BufferPointer bp) => new _UnlinkedPartImpl(bp);
}

class _UnlinkedPartImpl extends Object with _UnlinkedPartMixin implements idl.UnlinkedPart {
  final fb.BufferPointer _bp;

  _UnlinkedPartImpl(this._bp);

  int _uriOffset;
  int _uriEnd;

  @override
  int get uriOffset {
    _uriOffset ??= const fb.Uint32Reader().vTableGet(_bp, 0, 0);
    return _uriOffset;
  }

  @override
  int get uriEnd {
    _uriEnd ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _uriEnd;
  }
}

abstract class _UnlinkedPartMixin implements idl.UnlinkedPart {
  @override
  Map<String, Object> toMap() => {
    "uriOffset": uriOffset,
    "uriEnd": uriEnd,
  };
}

class UnlinkedPublicNameBuilder extends Object with _UnlinkedPublicNameMixin implements idl.UnlinkedPublicName {
  bool _finished = false;

  String _name;
  idl.ReferenceKind _kind;
  int _numTypeParameters;
  List<UnlinkedPublicNameBuilder> _constMembers;

  @override
  String get name => _name ??= '';

  /**
   * The name itself.
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  idl.ReferenceKind get kind => _kind ??= idl.ReferenceKind.classOrEnum;

  /**
   * The kind of object referred to by the name.
   */
  void set kind(idl.ReferenceKind _value) {
    assert(!_finished);
    _kind = _value;
  }

  @override
  int get numTypeParameters => _numTypeParameters ??= 0;

  /**
   * If the entity being referred to is generic, the number of type parameters
   * it accepts.  Otherwise zero.
   */
  void set numTypeParameters(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _numTypeParameters = _value;
  }

  @override
  List<UnlinkedPublicNameBuilder> get constMembers => _constMembers ??= <UnlinkedPublicNameBuilder>[];

  /**
   * If this [UnlinkedPublicName] is a class, the list of members which can be
   * referenced from constants - static constant fields, static methods, and
   * constructors.  Otherwise empty.
   */
  void set constMembers(List<UnlinkedPublicNameBuilder> _value) {
    assert(!_finished);
    _constMembers = _value;
  }

  UnlinkedPublicNameBuilder({String name, idl.ReferenceKind kind, int numTypeParameters, List<UnlinkedPublicNameBuilder> constMembers})
    : _name = name,
      _kind = kind,
      _numTypeParameters = numTypeParameters,
      _constMembers = constMembers;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    fb.Offset offset_constMembers;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    if (!(_constMembers == null || _constMembers.isEmpty)) {
      offset_constMembers = fbBuilder.writeList(_constMembers.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_name != null) {
      fbBuilder.addOffset(0, offset_name);
    }
    if (_kind != null && _kind != idl.ReferenceKind.classOrEnum) {
      fbBuilder.addUint32(1, _kind.index);
    }
    if (_numTypeParameters != null && _numTypeParameters != 0) {
      fbBuilder.addUint32(2, _numTypeParameters);
    }
    if (offset_constMembers != null) {
      fbBuilder.addOffset(3, offset_constMembers);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedPublicNameReader extends fb.TableReader<_UnlinkedPublicNameImpl> {
  const _UnlinkedPublicNameReader();

  @override
  _UnlinkedPublicNameImpl createObject(fb.BufferPointer bp) => new _UnlinkedPublicNameImpl(bp);
}

class _UnlinkedPublicNameImpl extends Object with _UnlinkedPublicNameMixin implements idl.UnlinkedPublicName {
  final fb.BufferPointer _bp;

  _UnlinkedPublicNameImpl(this._bp);

  String _name;
  idl.ReferenceKind _kind;
  int _numTypeParameters;
  List<idl.UnlinkedPublicName> _constMembers;

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _name;
  }

  @override
  idl.ReferenceKind get kind {
    _kind ??= const _ReferenceKindReader().vTableGet(_bp, 1, idl.ReferenceKind.classOrEnum);
    return _kind;
  }

  @override
  int get numTypeParameters {
    _numTypeParameters ??= const fb.Uint32Reader().vTableGet(_bp, 2, 0);
    return _numTypeParameters;
  }

  @override
  List<idl.UnlinkedPublicName> get constMembers {
    _constMembers ??= const fb.ListReader<idl.UnlinkedPublicName>(const _UnlinkedPublicNameReader()).vTableGet(_bp, 3, const <idl.UnlinkedPublicName>[]);
    return _constMembers;
  }
}

abstract class _UnlinkedPublicNameMixin implements idl.UnlinkedPublicName {
  @override
  Map<String, Object> toMap() => {
    "name": name,
    "kind": kind,
    "numTypeParameters": numTypeParameters,
    "constMembers": constMembers,
  };
}

class UnlinkedPublicNamespaceBuilder extends Object with _UnlinkedPublicNamespaceMixin implements idl.UnlinkedPublicNamespace {
  bool _finished = false;

  List<UnlinkedPublicNameBuilder> _names;
  List<UnlinkedExportPublicBuilder> _exports;
  List<String> _parts;

  @override
  List<UnlinkedPublicNameBuilder> get names => _names ??= <UnlinkedPublicNameBuilder>[];

  /**
   * Public names defined in the compilation unit.
   *
   * TODO(paulberry): consider sorting these names to reduce unnecessary
   * relinking.
   */
  void set names(List<UnlinkedPublicNameBuilder> _value) {
    assert(!_finished);
    _names = _value;
  }

  @override
  List<UnlinkedExportPublicBuilder> get exports => _exports ??= <UnlinkedExportPublicBuilder>[];

  /**
   * Export declarations in the compilation unit.
   */
  void set exports(List<UnlinkedExportPublicBuilder> _value) {
    assert(!_finished);
    _exports = _value;
  }

  @override
  List<String> get parts => _parts ??= <String>[];

  /**
   * URIs referenced by part declarations in the compilation unit.
   */
  void set parts(List<String> _value) {
    assert(!_finished);
    _parts = _value;
  }

  UnlinkedPublicNamespaceBuilder({List<UnlinkedPublicNameBuilder> names, List<UnlinkedExportPublicBuilder> exports, List<String> parts})
    : _names = names,
      _exports = exports,
      _parts = parts;

  List<int> toBuffer() {
    fb.Builder fbBuilder = new fb.Builder();
    return fbBuilder.finish(finish(fbBuilder));
  }

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_names;
    fb.Offset offset_exports;
    fb.Offset offset_parts;
    if (!(_names == null || _names.isEmpty)) {
      offset_names = fbBuilder.writeList(_names.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_exports == null || _exports.isEmpty)) {
      offset_exports = fbBuilder.writeList(_exports.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_parts == null || _parts.isEmpty)) {
      offset_parts = fbBuilder.writeList(_parts.map((b) => fbBuilder.writeString(b)).toList());
    }
    fbBuilder.startTable();
    if (offset_names != null) {
      fbBuilder.addOffset(0, offset_names);
    }
    if (offset_exports != null) {
      fbBuilder.addOffset(1, offset_exports);
    }
    if (offset_parts != null) {
      fbBuilder.addOffset(2, offset_parts);
    }
    return fbBuilder.endTable();
  }
}

idl.UnlinkedPublicNamespace readUnlinkedPublicNamespace(List<int> buffer) {
  fb.BufferPointer rootRef = new fb.BufferPointer.fromBytes(buffer);
  return const _UnlinkedPublicNamespaceReader().read(rootRef);
}

class _UnlinkedPublicNamespaceReader extends fb.TableReader<_UnlinkedPublicNamespaceImpl> {
  const _UnlinkedPublicNamespaceReader();

  @override
  _UnlinkedPublicNamespaceImpl createObject(fb.BufferPointer bp) => new _UnlinkedPublicNamespaceImpl(bp);
}

class _UnlinkedPublicNamespaceImpl extends Object with _UnlinkedPublicNamespaceMixin implements idl.UnlinkedPublicNamespace {
  final fb.BufferPointer _bp;

  _UnlinkedPublicNamespaceImpl(this._bp);

  List<idl.UnlinkedPublicName> _names;
  List<idl.UnlinkedExportPublic> _exports;
  List<String> _parts;

  @override
  List<idl.UnlinkedPublicName> get names {
    _names ??= const fb.ListReader<idl.UnlinkedPublicName>(const _UnlinkedPublicNameReader()).vTableGet(_bp, 0, const <idl.UnlinkedPublicName>[]);
    return _names;
  }

  @override
  List<idl.UnlinkedExportPublic> get exports {
    _exports ??= const fb.ListReader<idl.UnlinkedExportPublic>(const _UnlinkedExportPublicReader()).vTableGet(_bp, 1, const <idl.UnlinkedExportPublic>[]);
    return _exports;
  }

  @override
  List<String> get parts {
    _parts ??= const fb.ListReader<String>(const fb.StringReader()).vTableGet(_bp, 2, const <String>[]);
    return _parts;
  }
}

abstract class _UnlinkedPublicNamespaceMixin implements idl.UnlinkedPublicNamespace {
  @override
  Map<String, Object> toMap() => {
    "names": names,
    "exports": exports,
    "parts": parts,
  };
}

class UnlinkedReferenceBuilder extends Object with _UnlinkedReferenceMixin implements idl.UnlinkedReference {
  bool _finished = false;

  String _name;
  int _prefixReference;

  @override
  String get name => _name ??= '';

  /**
   * Name of the entity being referred to.  For the pseudo-type `dynamic`, the
   * string is "dynamic".  For the pseudo-type `void`, the string is "void".
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  int get prefixReference => _prefixReference ??= 0;

  /**
   * Prefix used to refer to the entity, or zero if no prefix is used.  This is
   * an index into [UnlinkedUnit.references].
   *
   * Prefix references must always point backward; that is, for all i, if
   * UnlinkedUnit.references[i].prefixReference != 0, then
   * UnlinkedUnit.references[i].prefixReference < i.
   */
  void set prefixReference(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _prefixReference = _value;
  }

  UnlinkedReferenceBuilder({String name, int prefixReference})
    : _name = name,
      _prefixReference = prefixReference;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    fbBuilder.startTable();
    if (offset_name != null) {
      fbBuilder.addOffset(0, offset_name);
    }
    if (_prefixReference != null && _prefixReference != 0) {
      fbBuilder.addUint32(1, _prefixReference);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedReferenceReader extends fb.TableReader<_UnlinkedReferenceImpl> {
  const _UnlinkedReferenceReader();

  @override
  _UnlinkedReferenceImpl createObject(fb.BufferPointer bp) => new _UnlinkedReferenceImpl(bp);
}

class _UnlinkedReferenceImpl extends Object with _UnlinkedReferenceMixin implements idl.UnlinkedReference {
  final fb.BufferPointer _bp;

  _UnlinkedReferenceImpl(this._bp);

  String _name;
  int _prefixReference;

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _name;
  }

  @override
  int get prefixReference {
    _prefixReference ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _prefixReference;
  }
}

abstract class _UnlinkedReferenceMixin implements idl.UnlinkedReference {
  @override
  Map<String, Object> toMap() => {
    "name": name,
    "prefixReference": prefixReference,
  };
}

class UnlinkedTypedefBuilder extends Object with _UnlinkedTypedefMixin implements idl.UnlinkedTypedef {
  bool _finished = false;

  String _name;
  int _nameOffset;
  UnlinkedDocumentationCommentBuilder _documentationComment;
  List<UnlinkedTypeParamBuilder> _typeParameters;
  EntityRefBuilder _returnType;
  List<UnlinkedParamBuilder> _parameters;

  @override
  String get name => _name ??= '';

  /**
   * Name of the typedef.
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  int get nameOffset => _nameOffset ??= 0;

  /**
   * Offset of the typedef name relative to the beginning of the file.
   */
  void set nameOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _nameOffset = _value;
  }

  @override
  UnlinkedDocumentationCommentBuilder get documentationComment => _documentationComment;

  /**
   * Documentation comment for the typedef, or `null` if there is no
   * documentation comment.
   */
  void set documentationComment(UnlinkedDocumentationCommentBuilder _value) {
    assert(!_finished);
    _documentationComment = _value;
  }

  @override
  List<UnlinkedTypeParamBuilder> get typeParameters => _typeParameters ??= <UnlinkedTypeParamBuilder>[];

  /**
   * Type parameters of the typedef, if any.
   */
  void set typeParameters(List<UnlinkedTypeParamBuilder> _value) {
    assert(!_finished);
    _typeParameters = _value;
  }

  @override
  EntityRefBuilder get returnType => _returnType;

  /**
   * Return type of the typedef.
   */
  void set returnType(EntityRefBuilder _value) {
    assert(!_finished);
    _returnType = _value;
  }

  @override
  List<UnlinkedParamBuilder> get parameters => _parameters ??= <UnlinkedParamBuilder>[];

  /**
   * Parameters of the executable, if any.
   */
  void set parameters(List<UnlinkedParamBuilder> _value) {
    assert(!_finished);
    _parameters = _value;
  }

  UnlinkedTypedefBuilder({String name, int nameOffset, UnlinkedDocumentationCommentBuilder documentationComment, List<UnlinkedTypeParamBuilder> typeParameters, EntityRefBuilder returnType, List<UnlinkedParamBuilder> parameters})
    : _name = name,
      _nameOffset = nameOffset,
      _documentationComment = documentationComment,
      _typeParameters = typeParameters,
      _returnType = returnType,
      _parameters = parameters;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    fb.Offset offset_documentationComment;
    fb.Offset offset_typeParameters;
    fb.Offset offset_returnType;
    fb.Offset offset_parameters;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    if (_documentationComment != null) {
      offset_documentationComment = _documentationComment.finish(fbBuilder);
    }
    if (!(_typeParameters == null || _typeParameters.isEmpty)) {
      offset_typeParameters = fbBuilder.writeList(_typeParameters.map((b) => b.finish(fbBuilder)).toList());
    }
    if (_returnType != null) {
      offset_returnType = _returnType.finish(fbBuilder);
    }
    if (!(_parameters == null || _parameters.isEmpty)) {
      offset_parameters = fbBuilder.writeList(_parameters.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_name != null) {
      fbBuilder.addOffset(0, offset_name);
    }
    if (_nameOffset != null && _nameOffset != 0) {
      fbBuilder.addUint32(1, _nameOffset);
    }
    if (offset_documentationComment != null) {
      fbBuilder.addOffset(2, offset_documentationComment);
    }
    if (offset_typeParameters != null) {
      fbBuilder.addOffset(3, offset_typeParameters);
    }
    if (offset_returnType != null) {
      fbBuilder.addOffset(4, offset_returnType);
    }
    if (offset_parameters != null) {
      fbBuilder.addOffset(5, offset_parameters);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedTypedefReader extends fb.TableReader<_UnlinkedTypedefImpl> {
  const _UnlinkedTypedefReader();

  @override
  _UnlinkedTypedefImpl createObject(fb.BufferPointer bp) => new _UnlinkedTypedefImpl(bp);
}

class _UnlinkedTypedefImpl extends Object with _UnlinkedTypedefMixin implements idl.UnlinkedTypedef {
  final fb.BufferPointer _bp;

  _UnlinkedTypedefImpl(this._bp);

  String _name;
  int _nameOffset;
  idl.UnlinkedDocumentationComment _documentationComment;
  List<idl.UnlinkedTypeParam> _typeParameters;
  idl.EntityRef _returnType;
  List<idl.UnlinkedParam> _parameters;

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _name;
  }

  @override
  int get nameOffset {
    _nameOffset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _nameOffset;
  }

  @override
  idl.UnlinkedDocumentationComment get documentationComment {
    _documentationComment ??= const _UnlinkedDocumentationCommentReader().vTableGet(_bp, 2, null);
    return _documentationComment;
  }

  @override
  List<idl.UnlinkedTypeParam> get typeParameters {
    _typeParameters ??= const fb.ListReader<idl.UnlinkedTypeParam>(const _UnlinkedTypeParamReader()).vTableGet(_bp, 3, const <idl.UnlinkedTypeParam>[]);
    return _typeParameters;
  }

  @override
  idl.EntityRef get returnType {
    _returnType ??= const _EntityRefReader().vTableGet(_bp, 4, null);
    return _returnType;
  }

  @override
  List<idl.UnlinkedParam> get parameters {
    _parameters ??= const fb.ListReader<idl.UnlinkedParam>(const _UnlinkedParamReader()).vTableGet(_bp, 5, const <idl.UnlinkedParam>[]);
    return _parameters;
  }
}

abstract class _UnlinkedTypedefMixin implements idl.UnlinkedTypedef {
  @override
  Map<String, Object> toMap() => {
    "name": name,
    "nameOffset": nameOffset,
    "documentationComment": documentationComment,
    "typeParameters": typeParameters,
    "returnType": returnType,
    "parameters": parameters,
  };
}

class UnlinkedTypeParamBuilder extends Object with _UnlinkedTypeParamMixin implements idl.UnlinkedTypeParam {
  bool _finished = false;

  String _name;
  int _nameOffset;
  EntityRefBuilder _bound;

  @override
  String get name => _name ??= '';

  /**
   * Name of the type parameter.
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  int get nameOffset => _nameOffset ??= 0;

  /**
   * Offset of the type parameter name relative to the beginning of the file.
   */
  void set nameOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _nameOffset = _value;
  }

  @override
  EntityRefBuilder get bound => _bound;

  /**
   * Bound of the type parameter, if a bound is explicitly declared.  Otherwise
   * null.
   */
  void set bound(EntityRefBuilder _value) {
    assert(!_finished);
    _bound = _value;
  }

  UnlinkedTypeParamBuilder({String name, int nameOffset, EntityRefBuilder bound})
    : _name = name,
      _nameOffset = nameOffset,
      _bound = bound;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    fb.Offset offset_bound;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    if (_bound != null) {
      offset_bound = _bound.finish(fbBuilder);
    }
    fbBuilder.startTable();
    if (offset_name != null) {
      fbBuilder.addOffset(0, offset_name);
    }
    if (_nameOffset != null && _nameOffset != 0) {
      fbBuilder.addUint32(1, _nameOffset);
    }
    if (offset_bound != null) {
      fbBuilder.addOffset(2, offset_bound);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedTypeParamReader extends fb.TableReader<_UnlinkedTypeParamImpl> {
  const _UnlinkedTypeParamReader();

  @override
  _UnlinkedTypeParamImpl createObject(fb.BufferPointer bp) => new _UnlinkedTypeParamImpl(bp);
}

class _UnlinkedTypeParamImpl extends Object with _UnlinkedTypeParamMixin implements idl.UnlinkedTypeParam {
  final fb.BufferPointer _bp;

  _UnlinkedTypeParamImpl(this._bp);

  String _name;
  int _nameOffset;
  idl.EntityRef _bound;

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _name;
  }

  @override
  int get nameOffset {
    _nameOffset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _nameOffset;
  }

  @override
  idl.EntityRef get bound {
    _bound ??= const _EntityRefReader().vTableGet(_bp, 2, null);
    return _bound;
  }
}

abstract class _UnlinkedTypeParamMixin implements idl.UnlinkedTypeParam {
  @override
  Map<String, Object> toMap() => {
    "name": name,
    "nameOffset": nameOffset,
    "bound": bound,
  };
}

class UnlinkedUnitBuilder extends Object with _UnlinkedUnitMixin implements idl.UnlinkedUnit {
  bool _finished = false;

  String _libraryName;
  int _libraryNameOffset;
  int _libraryNameLength;
  UnlinkedDocumentationCommentBuilder _libraryDocumentationComment;
  UnlinkedPublicNamespaceBuilder _publicNamespace;
  List<UnlinkedReferenceBuilder> _references;
  List<UnlinkedClassBuilder> _classes;
  List<UnlinkedEnumBuilder> _enums;
  List<UnlinkedExecutableBuilder> _executables;
  List<UnlinkedExportNonPublicBuilder> _exports;
  List<UnlinkedImportBuilder> _imports;
  List<UnlinkedPartBuilder> _parts;
  List<UnlinkedTypedefBuilder> _typedefs;
  List<UnlinkedVariableBuilder> _variables;

  @override
  String get libraryName => _libraryName ??= '';

  /**
   * Name of the library (from a "library" declaration, if present).
   */
  void set libraryName(String _value) {
    assert(!_finished);
    _libraryName = _value;
  }

  @override
  int get libraryNameOffset => _libraryNameOffset ??= 0;

  /**
   * Offset of the library name relative to the beginning of the file (or 0 if
   * the library has no name).
   */
  void set libraryNameOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _libraryNameOffset = _value;
  }

  @override
  int get libraryNameLength => _libraryNameLength ??= 0;

  /**
   * Length of the library name as it appears in the source code (or 0 if the
   * library has no name).
   */
  void set libraryNameLength(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _libraryNameLength = _value;
  }

  @override
  UnlinkedDocumentationCommentBuilder get libraryDocumentationComment => _libraryDocumentationComment;

  /**
   * Documentation comment for the library, or `null` if there is no
   * documentation comment.
   */
  void set libraryDocumentationComment(UnlinkedDocumentationCommentBuilder _value) {
    assert(!_finished);
    _libraryDocumentationComment = _value;
  }

  @override
  UnlinkedPublicNamespaceBuilder get publicNamespace => _publicNamespace;

  /**
   * Unlinked public namespace of this compilation unit.
   */
  void set publicNamespace(UnlinkedPublicNamespaceBuilder _value) {
    assert(!_finished);
    _publicNamespace = _value;
  }

  @override
  List<UnlinkedReferenceBuilder> get references => _references ??= <UnlinkedReferenceBuilder>[];

  /**
   * Top level and prefixed names referred to by this compilation unit.  The
   * zeroth element of this array is always populated and is used to represent
   * the absence of a reference in places where a reference is optional (for
   * example [UnlinkedReference.prefixReference or
   * UnlinkedImport.prefixReference]).
   */
  void set references(List<UnlinkedReferenceBuilder> _value) {
    assert(!_finished);
    _references = _value;
  }

  @override
  List<UnlinkedClassBuilder> get classes => _classes ??= <UnlinkedClassBuilder>[];

  /**
   * Classes declared in the compilation unit.
   */
  void set classes(List<UnlinkedClassBuilder> _value) {
    assert(!_finished);
    _classes = _value;
  }

  @override
  List<UnlinkedEnumBuilder> get enums => _enums ??= <UnlinkedEnumBuilder>[];

  /**
   * Enums declared in the compilation unit.
   */
  void set enums(List<UnlinkedEnumBuilder> _value) {
    assert(!_finished);
    _enums = _value;
  }

  @override
  List<UnlinkedExecutableBuilder> get executables => _executables ??= <UnlinkedExecutableBuilder>[];

  /**
   * Top level executable objects (functions, getters, and setters) declared in
   * the compilation unit.
   */
  void set executables(List<UnlinkedExecutableBuilder> _value) {
    assert(!_finished);
    _executables = _value;
  }

  @override
  List<UnlinkedExportNonPublicBuilder> get exports => _exports ??= <UnlinkedExportNonPublicBuilder>[];

  /**
   * Export declarations in the compilation unit.
   */
  void set exports(List<UnlinkedExportNonPublicBuilder> _value) {
    assert(!_finished);
    _exports = _value;
  }

  @override
  List<UnlinkedImportBuilder> get imports => _imports ??= <UnlinkedImportBuilder>[];

  /**
   * Import declarations in the compilation unit.
   */
  void set imports(List<UnlinkedImportBuilder> _value) {
    assert(!_finished);
    _imports = _value;
  }

  @override
  List<UnlinkedPartBuilder> get parts => _parts ??= <UnlinkedPartBuilder>[];

  /**
   * Part declarations in the compilation unit.
   */
  void set parts(List<UnlinkedPartBuilder> _value) {
    assert(!_finished);
    _parts = _value;
  }

  @override
  List<UnlinkedTypedefBuilder> get typedefs => _typedefs ??= <UnlinkedTypedefBuilder>[];

  /**
   * Typedefs declared in the compilation unit.
   */
  void set typedefs(List<UnlinkedTypedefBuilder> _value) {
    assert(!_finished);
    _typedefs = _value;
  }

  @override
  List<UnlinkedVariableBuilder> get variables => _variables ??= <UnlinkedVariableBuilder>[];

  /**
   * Top level variables declared in the compilation unit.
   */
  void set variables(List<UnlinkedVariableBuilder> _value) {
    assert(!_finished);
    _variables = _value;
  }

  UnlinkedUnitBuilder({String libraryName, int libraryNameOffset, int libraryNameLength, UnlinkedDocumentationCommentBuilder libraryDocumentationComment, UnlinkedPublicNamespaceBuilder publicNamespace, List<UnlinkedReferenceBuilder> references, List<UnlinkedClassBuilder> classes, List<UnlinkedEnumBuilder> enums, List<UnlinkedExecutableBuilder> executables, List<UnlinkedExportNonPublicBuilder> exports, List<UnlinkedImportBuilder> imports, List<UnlinkedPartBuilder> parts, List<UnlinkedTypedefBuilder> typedefs, List<UnlinkedVariableBuilder> variables})
    : _libraryName = libraryName,
      _libraryNameOffset = libraryNameOffset,
      _libraryNameLength = libraryNameLength,
      _libraryDocumentationComment = libraryDocumentationComment,
      _publicNamespace = publicNamespace,
      _references = references,
      _classes = classes,
      _enums = enums,
      _executables = executables,
      _exports = exports,
      _imports = imports,
      _parts = parts,
      _typedefs = typedefs,
      _variables = variables;

  List<int> toBuffer() {
    fb.Builder fbBuilder = new fb.Builder();
    return fbBuilder.finish(finish(fbBuilder));
  }

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_libraryName;
    fb.Offset offset_libraryDocumentationComment;
    fb.Offset offset_publicNamespace;
    fb.Offset offset_references;
    fb.Offset offset_classes;
    fb.Offset offset_enums;
    fb.Offset offset_executables;
    fb.Offset offset_exports;
    fb.Offset offset_imports;
    fb.Offset offset_parts;
    fb.Offset offset_typedefs;
    fb.Offset offset_variables;
    if (_libraryName != null) {
      offset_libraryName = fbBuilder.writeString(_libraryName);
    }
    if (_libraryDocumentationComment != null) {
      offset_libraryDocumentationComment = _libraryDocumentationComment.finish(fbBuilder);
    }
    if (_publicNamespace != null) {
      offset_publicNamespace = _publicNamespace.finish(fbBuilder);
    }
    if (!(_references == null || _references.isEmpty)) {
      offset_references = fbBuilder.writeList(_references.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_classes == null || _classes.isEmpty)) {
      offset_classes = fbBuilder.writeList(_classes.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_enums == null || _enums.isEmpty)) {
      offset_enums = fbBuilder.writeList(_enums.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_executables == null || _executables.isEmpty)) {
      offset_executables = fbBuilder.writeList(_executables.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_exports == null || _exports.isEmpty)) {
      offset_exports = fbBuilder.writeList(_exports.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_imports == null || _imports.isEmpty)) {
      offset_imports = fbBuilder.writeList(_imports.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_parts == null || _parts.isEmpty)) {
      offset_parts = fbBuilder.writeList(_parts.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_typedefs == null || _typedefs.isEmpty)) {
      offset_typedefs = fbBuilder.writeList(_typedefs.map((b) => b.finish(fbBuilder)).toList());
    }
    if (!(_variables == null || _variables.isEmpty)) {
      offset_variables = fbBuilder.writeList(_variables.map((b) => b.finish(fbBuilder)).toList());
    }
    fbBuilder.startTable();
    if (offset_libraryName != null) {
      fbBuilder.addOffset(0, offset_libraryName);
    }
    if (_libraryNameOffset != null && _libraryNameOffset != 0) {
      fbBuilder.addUint32(1, _libraryNameOffset);
    }
    if (_libraryNameLength != null && _libraryNameLength != 0) {
      fbBuilder.addUint32(2, _libraryNameLength);
    }
    if (offset_libraryDocumentationComment != null) {
      fbBuilder.addOffset(3, offset_libraryDocumentationComment);
    }
    if (offset_publicNamespace != null) {
      fbBuilder.addOffset(4, offset_publicNamespace);
    }
    if (offset_references != null) {
      fbBuilder.addOffset(5, offset_references);
    }
    if (offset_classes != null) {
      fbBuilder.addOffset(6, offset_classes);
    }
    if (offset_enums != null) {
      fbBuilder.addOffset(7, offset_enums);
    }
    if (offset_executables != null) {
      fbBuilder.addOffset(8, offset_executables);
    }
    if (offset_exports != null) {
      fbBuilder.addOffset(9, offset_exports);
    }
    if (offset_imports != null) {
      fbBuilder.addOffset(10, offset_imports);
    }
    if (offset_parts != null) {
      fbBuilder.addOffset(11, offset_parts);
    }
    if (offset_typedefs != null) {
      fbBuilder.addOffset(12, offset_typedefs);
    }
    if (offset_variables != null) {
      fbBuilder.addOffset(13, offset_variables);
    }
    return fbBuilder.endTable();
  }
}

idl.UnlinkedUnit readUnlinkedUnit(List<int> buffer) {
  fb.BufferPointer rootRef = new fb.BufferPointer.fromBytes(buffer);
  return const _UnlinkedUnitReader().read(rootRef);
}

class _UnlinkedUnitReader extends fb.TableReader<_UnlinkedUnitImpl> {
  const _UnlinkedUnitReader();

  @override
  _UnlinkedUnitImpl createObject(fb.BufferPointer bp) => new _UnlinkedUnitImpl(bp);
}

class _UnlinkedUnitImpl extends Object with _UnlinkedUnitMixin implements idl.UnlinkedUnit {
  final fb.BufferPointer _bp;

  _UnlinkedUnitImpl(this._bp);

  String _libraryName;
  int _libraryNameOffset;
  int _libraryNameLength;
  idl.UnlinkedDocumentationComment _libraryDocumentationComment;
  idl.UnlinkedPublicNamespace _publicNamespace;
  List<idl.UnlinkedReference> _references;
  List<idl.UnlinkedClass> _classes;
  List<idl.UnlinkedEnum> _enums;
  List<idl.UnlinkedExecutable> _executables;
  List<idl.UnlinkedExportNonPublic> _exports;
  List<idl.UnlinkedImport> _imports;
  List<idl.UnlinkedPart> _parts;
  List<idl.UnlinkedTypedef> _typedefs;
  List<idl.UnlinkedVariable> _variables;

  @override
  String get libraryName {
    _libraryName ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _libraryName;
  }

  @override
  int get libraryNameOffset {
    _libraryNameOffset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _libraryNameOffset;
  }

  @override
  int get libraryNameLength {
    _libraryNameLength ??= const fb.Uint32Reader().vTableGet(_bp, 2, 0);
    return _libraryNameLength;
  }

  @override
  idl.UnlinkedDocumentationComment get libraryDocumentationComment {
    _libraryDocumentationComment ??= const _UnlinkedDocumentationCommentReader().vTableGet(_bp, 3, null);
    return _libraryDocumentationComment;
  }

  @override
  idl.UnlinkedPublicNamespace get publicNamespace {
    _publicNamespace ??= const _UnlinkedPublicNamespaceReader().vTableGet(_bp, 4, null);
    return _publicNamespace;
  }

  @override
  List<idl.UnlinkedReference> get references {
    _references ??= const fb.ListReader<idl.UnlinkedReference>(const _UnlinkedReferenceReader()).vTableGet(_bp, 5, const <idl.UnlinkedReference>[]);
    return _references;
  }

  @override
  List<idl.UnlinkedClass> get classes {
    _classes ??= const fb.ListReader<idl.UnlinkedClass>(const _UnlinkedClassReader()).vTableGet(_bp, 6, const <idl.UnlinkedClass>[]);
    return _classes;
  }

  @override
  List<idl.UnlinkedEnum> get enums {
    _enums ??= const fb.ListReader<idl.UnlinkedEnum>(const _UnlinkedEnumReader()).vTableGet(_bp, 7, const <idl.UnlinkedEnum>[]);
    return _enums;
  }

  @override
  List<idl.UnlinkedExecutable> get executables {
    _executables ??= const fb.ListReader<idl.UnlinkedExecutable>(const _UnlinkedExecutableReader()).vTableGet(_bp, 8, const <idl.UnlinkedExecutable>[]);
    return _executables;
  }

  @override
  List<idl.UnlinkedExportNonPublic> get exports {
    _exports ??= const fb.ListReader<idl.UnlinkedExportNonPublic>(const _UnlinkedExportNonPublicReader()).vTableGet(_bp, 9, const <idl.UnlinkedExportNonPublic>[]);
    return _exports;
  }

  @override
  List<idl.UnlinkedImport> get imports {
    _imports ??= const fb.ListReader<idl.UnlinkedImport>(const _UnlinkedImportReader()).vTableGet(_bp, 10, const <idl.UnlinkedImport>[]);
    return _imports;
  }

  @override
  List<idl.UnlinkedPart> get parts {
    _parts ??= const fb.ListReader<idl.UnlinkedPart>(const _UnlinkedPartReader()).vTableGet(_bp, 11, const <idl.UnlinkedPart>[]);
    return _parts;
  }

  @override
  List<idl.UnlinkedTypedef> get typedefs {
    _typedefs ??= const fb.ListReader<idl.UnlinkedTypedef>(const _UnlinkedTypedefReader()).vTableGet(_bp, 12, const <idl.UnlinkedTypedef>[]);
    return _typedefs;
  }

  @override
  List<idl.UnlinkedVariable> get variables {
    _variables ??= const fb.ListReader<idl.UnlinkedVariable>(const _UnlinkedVariableReader()).vTableGet(_bp, 13, const <idl.UnlinkedVariable>[]);
    return _variables;
  }
}

abstract class _UnlinkedUnitMixin implements idl.UnlinkedUnit {
  @override
  Map<String, Object> toMap() => {
    "libraryName": libraryName,
    "libraryNameOffset": libraryNameOffset,
    "libraryNameLength": libraryNameLength,
    "libraryDocumentationComment": libraryDocumentationComment,
    "publicNamespace": publicNamespace,
    "references": references,
    "classes": classes,
    "enums": enums,
    "executables": executables,
    "exports": exports,
    "imports": imports,
    "parts": parts,
    "typedefs": typedefs,
    "variables": variables,
  };
}

class UnlinkedVariableBuilder extends Object with _UnlinkedVariableMixin implements idl.UnlinkedVariable {
  bool _finished = false;

  String _name;
  int _nameOffset;
  UnlinkedDocumentationCommentBuilder _documentationComment;
  EntityRefBuilder _type;
  UnlinkedConstBuilder _constExpr;
  bool _isStatic;
  bool _isFinal;
  bool _isConst;
  int _propagatedTypeSlot;
  int _inferredTypeSlot;

  @override
  String get name => _name ??= '';

  /**
   * Name of the variable.
   */
  void set name(String _value) {
    assert(!_finished);
    _name = _value;
  }

  @override
  int get nameOffset => _nameOffset ??= 0;

  /**
   * Offset of the variable name relative to the beginning of the file.
   */
  void set nameOffset(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _nameOffset = _value;
  }

  @override
  UnlinkedDocumentationCommentBuilder get documentationComment => _documentationComment;

  /**
   * Documentation comment for the variable, or `null` if there is no
   * documentation comment.
   */
  void set documentationComment(UnlinkedDocumentationCommentBuilder _value) {
    assert(!_finished);
    _documentationComment = _value;
  }

  @override
  EntityRefBuilder get type => _type;

  /**
   * Declared type of the variable.  Absent if the type is implicit.
   */
  void set type(EntityRefBuilder _value) {
    assert(!_finished);
    _type = _value;
  }

  @override
  UnlinkedConstBuilder get constExpr => _constExpr;

  /**
   * If [isConst] is true, and the variable has an initializer, the constant
   * expression in the initializer.
   */
  void set constExpr(UnlinkedConstBuilder _value) {
    assert(!_finished);
    _constExpr = _value;
  }

  @override
  bool get isStatic => _isStatic ??= false;

  /**
   * Indicates whether the variable is declared using the `static` keyword.
   *
   * Note that for top level variables, this flag is false, since they are not
   * declared using the `static` keyword (even though they are considered
   * static for semantic purposes).
   */
  void set isStatic(bool _value) {
    assert(!_finished);
    _isStatic = _value;
  }

  @override
  bool get isFinal => _isFinal ??= false;

  /**
   * Indicates whether the variable is declared using the `final` keyword.
   */
  void set isFinal(bool _value) {
    assert(!_finished);
    _isFinal = _value;
  }

  @override
  bool get isConst => _isConst ??= false;

  /**
   * Indicates whether the variable is declared using the `const` keyword.
   */
  void set isConst(bool _value) {
    assert(!_finished);
    _isConst = _value;
  }

  @override
  int get propagatedTypeSlot => _propagatedTypeSlot ??= 0;

  /**
   * If this variable is propagable, nonzero slot id identifying which entry in
   * [LinkedLibrary.types] contains the propagated type for this variable.  If
   * there is no matching entry in [LinkedLibrary.types], then this variable's
   * propagated type is the same as its declared type.
   *
   * Non-propagable variables have a [propagatedTypeSlot] of zero.
   */
  void set propagatedTypeSlot(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _propagatedTypeSlot = _value;
  }

  @override
  int get inferredTypeSlot => _inferredTypeSlot ??= 0;

  /**
   * If this variable is inferable, nonzero slot id identifying which entry in
   * [LinkedLibrary.types] contains the inferred type for this variable.  If
   * there is no matching entry in [LinkedLibrary.types], then no type was
   * inferred for this variable, so its static type is `dynamic`.
   */
  void set inferredTypeSlot(int _value) {
    assert(!_finished);
    assert(_value == null || _value >= 0);
    _inferredTypeSlot = _value;
  }

  UnlinkedVariableBuilder({String name, int nameOffset, UnlinkedDocumentationCommentBuilder documentationComment, EntityRefBuilder type, UnlinkedConstBuilder constExpr, bool isStatic, bool isFinal, bool isConst, int propagatedTypeSlot, int inferredTypeSlot})
    : _name = name,
      _nameOffset = nameOffset,
      _documentationComment = documentationComment,
      _type = type,
      _constExpr = constExpr,
      _isStatic = isStatic,
      _isFinal = isFinal,
      _isConst = isConst,
      _propagatedTypeSlot = propagatedTypeSlot,
      _inferredTypeSlot = inferredTypeSlot;

  fb.Offset finish(fb.Builder fbBuilder) {
    assert(!_finished);
    _finished = true;
    fb.Offset offset_name;
    fb.Offset offset_documentationComment;
    fb.Offset offset_type;
    fb.Offset offset_constExpr;
    if (_name != null) {
      offset_name = fbBuilder.writeString(_name);
    }
    if (_documentationComment != null) {
      offset_documentationComment = _documentationComment.finish(fbBuilder);
    }
    if (_type != null) {
      offset_type = _type.finish(fbBuilder);
    }
    if (_constExpr != null) {
      offset_constExpr = _constExpr.finish(fbBuilder);
    }
    fbBuilder.startTable();
    if (offset_name != null) {
      fbBuilder.addOffset(0, offset_name);
    }
    if (_nameOffset != null && _nameOffset != 0) {
      fbBuilder.addUint32(1, _nameOffset);
    }
    if (offset_documentationComment != null) {
      fbBuilder.addOffset(2, offset_documentationComment);
    }
    if (offset_type != null) {
      fbBuilder.addOffset(3, offset_type);
    }
    if (offset_constExpr != null) {
      fbBuilder.addOffset(4, offset_constExpr);
    }
    if (_isStatic == true) {
      fbBuilder.addBool(5, true);
    }
    if (_isFinal == true) {
      fbBuilder.addBool(6, true);
    }
    if (_isConst == true) {
      fbBuilder.addBool(7, true);
    }
    if (_propagatedTypeSlot != null && _propagatedTypeSlot != 0) {
      fbBuilder.addUint32(8, _propagatedTypeSlot);
    }
    if (_inferredTypeSlot != null && _inferredTypeSlot != 0) {
      fbBuilder.addUint32(9, _inferredTypeSlot);
    }
    return fbBuilder.endTable();
  }
}

class _UnlinkedVariableReader extends fb.TableReader<_UnlinkedVariableImpl> {
  const _UnlinkedVariableReader();

  @override
  _UnlinkedVariableImpl createObject(fb.BufferPointer bp) => new _UnlinkedVariableImpl(bp);
}

class _UnlinkedVariableImpl extends Object with _UnlinkedVariableMixin implements idl.UnlinkedVariable {
  final fb.BufferPointer _bp;

  _UnlinkedVariableImpl(this._bp);

  String _name;
  int _nameOffset;
  idl.UnlinkedDocumentationComment _documentationComment;
  idl.EntityRef _type;
  idl.UnlinkedConst _constExpr;
  bool _isStatic;
  bool _isFinal;
  bool _isConst;
  int _propagatedTypeSlot;
  int _inferredTypeSlot;

  @override
  String get name {
    _name ??= const fb.StringReader().vTableGet(_bp, 0, '');
    return _name;
  }

  @override
  int get nameOffset {
    _nameOffset ??= const fb.Uint32Reader().vTableGet(_bp, 1, 0);
    return _nameOffset;
  }

  @override
  idl.UnlinkedDocumentationComment get documentationComment {
    _documentationComment ??= const _UnlinkedDocumentationCommentReader().vTableGet(_bp, 2, null);
    return _documentationComment;
  }

  @override
  idl.EntityRef get type {
    _type ??= const _EntityRefReader().vTableGet(_bp, 3, null);
    return _type;
  }

  @override
  idl.UnlinkedConst get constExpr {
    _constExpr ??= const _UnlinkedConstReader().vTableGet(_bp, 4, null);
    return _constExpr;
  }

  @override
  bool get isStatic {
    _isStatic ??= const fb.BoolReader().vTableGet(_bp, 5, false);
    return _isStatic;
  }

  @override
  bool get isFinal {
    _isFinal ??= const fb.BoolReader().vTableGet(_bp, 6, false);
    return _isFinal;
  }

  @override
  bool get isConst {
    _isConst ??= const fb.BoolReader().vTableGet(_bp, 7, false);
    return _isConst;
  }

  @override
  int get propagatedTypeSlot {
    _propagatedTypeSlot ??= const fb.Uint32Reader().vTableGet(_bp, 8, 0);
    return _propagatedTypeSlot;
  }

  @override
  int get inferredTypeSlot {
    _inferredTypeSlot ??= const fb.Uint32Reader().vTableGet(_bp, 9, 0);
    return _inferredTypeSlot;
  }
}

abstract class _UnlinkedVariableMixin implements idl.UnlinkedVariable {
  @override
  Map<String, Object> toMap() => {
    "name": name,
    "nameOffset": nameOffset,
    "documentationComment": documentationComment,
    "type": type,
    "constExpr": constExpr,
    "isStatic": isStatic,
    "isFinal": isFinal,
    "isConst": isConst,
    "propagatedTypeSlot": propagatedTypeSlot,
    "inferredTypeSlot": inferredTypeSlot,
  };
}

