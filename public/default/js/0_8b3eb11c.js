(window.webpackJsonp = window.webpackJsonp || []).push([[0], {
    829: function (module, exports, __webpack_require__) {
        "use strict";
        (function (module) {
            Object.defineProperty(exports, "__esModule", {value: !0}), exports.default = void 0;
            var _upload = __webpack_require__(386), _upload2 = _interopRequireDefault(_upload),
                _select = __webpack_require__(55), _select2 = _interopRequireDefault(_select),
                _input = __webpack_require__(46), _input2 = _interopRequireDefault(_input),
                _button = __webpack_require__(27), _button2 = _interopRequireDefault(_button),
                _form = __webpack_require__(75), _form2 = _interopRequireDefault(_form),
                _extends2 = __webpack_require__(2), _extends3 = _interopRequireDefault(_extends2),
                _radio = __webpack_require__(109), _radio2 = _interopRequireDefault(_radio),
                _row = __webpack_require__(160), _row2 = _interopRequireDefault(_row), _col = __webpack_require__(159),
                _col2 = _interopRequireDefault(_col), _steps = __webpack_require__(835),
                _steps2 = _interopRequireDefault(_steps), _getPrototypeOf = __webpack_require__(19),
                _getPrototypeOf2 = _interopRequireDefault(_getPrototypeOf), _message2 = __webpack_require__(40),
                _message3 = _interopRequireDefault(_message2), _classCallCheck2 = __webpack_require__(4),
                _classCallCheck3 = _interopRequireDefault(_classCallCheck2),
                _possibleConstructorReturn2 = __webpack_require__(3),
                _possibleConstructorReturn3 = _interopRequireDefault(_possibleConstructorReturn2),
                _createClass2 = __webpack_require__(8), _createClass3 = _interopRequireDefault(_createClass2),
                _inherits2 = __webpack_require__(5), _inherits3 = _interopRequireDefault(_inherits2), _dec, _class;
            __webpack_require__(385), __webpack_require__(65), __webpack_require__(31), __webpack_require__(28), __webpack_require__(74), __webpack_require__(161), __webpack_require__(158), __webpack_require__(157), __webpack_require__(834), __webpack_require__(39);
            var _react = __webpack_require__(1), _react2 = _interopRequireDefault(_react),
                _mobxReact = __webpack_require__(24), _reactRouterDom = __webpack_require__(22),
                _writer = __webpack_require__(23), writerApis = _interopRequireWildcard(_writer),
                _config = __webpack_require__(56), enterModule;

            function _interopRequireWildcard(e) {
                if (e && e.__esModule)return e;
                var t = {};
                if (null != e)for (var a in e)Object.prototype.hasOwnProperty.call(e, a) && (t[a] = e[a]);
                return t.default = e, t
            }

            function _interopRequireDefault(e) {
                return e && e.__esModule ? e : {default: e}
            }

            __webpack_require__(837), enterModule = __webpack_require__(7).enterModule, enterModule && enterModule(module);
            var CreateBook = (_dec = (0, _mobxReact.inject)("userStore", "bookStore"), _dec(_class = (0, _reactRouterDom.withRouter)(_class = (0, _mobxReact.observer)(_class = function (_Component) {
                        function CreateBook(e) {
                            (0, _classCallCheck3.default)(this, CreateBook);
                            var t = (0, _possibleConstructorReturn3.default)(this, (CreateBook.__proto__ || (0, _getPrototypeOf2.default)(CreateBook)).call(this, e));
                            return t.handleChangeState = t.handleChangeState.bind(t), t.handleUpload = t.handleUpload.bind(t), t.handlePreCheck = t.handlePreCheck.bind(t), t.handleSubmit = t.handleSubmit.bind(t), t.state = {
                                currentStep: 0,
                                sexType: 10,
                                name: null,
                                categoryId: "",
                                authorizeType: null,
                                description: null,
                                coverFullUrl: null,
                                cover: null,
                                createNovelId: null
                            }, t
                        }

                        return (0, _inherits3.default)(CreateBook, _Component), (0, _createClass3.default)(CreateBook, null, [{
                            key: "handleUploadCheck",
                            value: function (e) {
                                var t = e.size / 1024 / 1024 < 5;
                                return t || _message3.default.error("鍥剧墖杩囧ぇ!"), t
                            }
                        }]), (0, _createClass3.default)(CreateBook, [{
                            key: "componentDidMount", value: function () {
                                var e = this.props.bookStore, t = e.categorys, a = e.getCategorys;
                                t.length || a()
                            }
                        }, {
                            key: "handleChangeState", value: function (e) {
                                this.setState(e)
                            }
                        }, {
                            key: "handleUpload", value: function (e) {
                                if ("uploading" !== e.file.status && "done" === e.file.status) {
                                    if (e.file.response && e.file.response.errcode)return void _message3.default.error(e.file.response.message);
                                    _message3.default.success("涓婁紶鎴愬姛"), this.setState({
                                        coverFullUrl: e.file.response.full_url.replace(/^http:|https:/, ""),
                                        cover: e.file.response.url
                                    })
                                }
                            }
                        }, {
                            key: "handlePreCheck", value: function () {
                                var e = this.state, t = e.name, a = e.categoryId, r = e.authorizeType,
                                    l = e.description;
                                t && /^\S{1,15}$/g.test(t) ? a ? r ? !l || l.length > 300 || l.length < 20 ? _message3.default.error("浣滃搧浠嬬粛瀛楁暟涓嶇") : this.handleSubmit() : _message3.default.error("璇烽€夋嫨鎺堟潈绫诲瀷") : _message3.default.error("璇烽€夋嫨浣滃搧绫诲瀷") : _message3.default.error("璇锋鏌ヤ綔鍝佸悕绉�")
                            }
                        }, {
                            key: "handleSubmit", value: function () {
                                var e = this, t = this.state, a = t.sexType, r = t.name, l = t.categoryId,
                                    n = t.authorizeType, i = t.description, o = t.cover;
                                writerApis.novelCreate({
                                    cover: o,
                                    name: r,
                                    categoryId: l,
                                    sexType: a,
                                    authorizeType: n,
                                    description: i
                                }).then(function (t) {
                                    e.setState({currentStep: 2, createNovelId: t.data.novel_id})
                                })
                            }
                        }, {
                            key: "render", value: function () {
                                var e = this, t = this.props.bookStore.categorys, a = this.state, r = a.currentStep,
                                    l = a.sexType, n = a.name, i = a.categoryId, o = a.authorizeType, c = a.description,
                                    s = a.coverFullUrl, u = a.createNovelId, _ = {
                                        labelCol: {span: 2, offset: 5},
                                        wrapperCol: {span: 11, style: {marginLeft: 10}},
                                        style: {marginBottom: 30}
                                    };
                                return _react2.default.createElement("div", {className: "create-book-wrap"}, _react2.default.createElement("h2", {className: "title"}, "鍒涘缓浣滃搧"), _react2.default.createElement(_row2.default, {style: {marginTop: 80}}, _react2.default.createElement(_col2.default, {
                                    span: 14,
                                    offset: 5
                                }, _react2.default.createElement(_steps2.default, {current: r}, _react2.default.createElement(_steps2.default.Step, {title: "閫夋嫨绫诲瀷"}), _react2.default.createElement(_steps2.default.Step, {title: "瀹屽杽浣滃搧淇℃伅"}), _react2.default.createElement(_steps2.default.Step, {title: "鍒涘缓鎴愬姛"})))), 0 == r ? _react2.default.createElement("div", {className: "step-0"}, _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    label: "鐩爣璇昏€�",
                                    required: !0
                                }), _react2.default.createElement(_radio2.default.Group, {value: l}, _react2.default.createElement("div", {
                                    className: "sex-type " + (10 === l ? "selected" : ""),
                                    onClick: function () {
                                        e.handleChangeState({sexType: 10})
                                    }
                                }, _react2.default.createElement(_radio2.default, {value: 10}, "鐢锋€�"), _react2.default.createElement("div", {className: "desc"}, "浠ョ敺鎬ц瑙掓垨鐢锋€у彈浼椾负涓荤殑浣滃搧锛岄兘甯傝█鎯�/绌胯秺鏋剁┖/鐜勫够浠欎緺/娴极闈掓槬/鎮枒鐏靛紓/閮藉競寮傝兘绛夋墍鏈夌敺鐢熼鏉�")), _react2.default.createElement("div", {
                                    className: "sex-type " + (20 === l ? "selected" : ""),
                                    style: {marginTop: 10},
                                    onClick: function () {
                                        e.handleChangeState({sexType: 20})
                                    }
                                }, _react2.default.createElement(_radio2.default, {value: 20}, "濂虫€�"), _react2.default.createElement("div", {className: "desc"}, "浠ュコ鎬ц瑙掓垨濂虫€у彈浼椾负涓荤殑浣滃搧锛岄兘甯傝█鎯�/绌胯秺鏋剁┖/鎬昏璞棬/鐜勫够浠欎緺/娴极闈掓槬/鎮枒鐏靛紓 绛夋墍鏈夊コ鐢熼鏉�")))), _react2.default.createElement(_form2.default.Item, {wrapperCol: {offset: 7}}, _react2.default.createElement(_button2.default, {
                                    style: {
                                        width: 160,
                                        marginLeft: 10
                                    }, type: "primary", size: "large", onClick: function () {
                                        e.handleChangeState({currentStep: 1})
                                    }
                                }, "涓嬩竴姝�"))) : null, 1 == r ? _react2.default.createElement("div", {className: "step-1"}, _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    help: "15瀛楀唴锛岃鍕挎坊鍔犱功鍚嶅彿绛夌壒娈婄鍙�",
                                    label: "浣滃搧鍚嶇О",
                                    required: !0
                                }), _react2.default.createElement(_input2.default, {
                                    size: "large",
                                    value: n,
                                    onChange: function (t) {
                                        e.handleChangeState({name: t.target.value})
                                    }
                                })), _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    label: "浣滃搧绫诲瀷",
                                    required: !0
                                }), _react2.default.createElement(_select2.default, {
                                    style: {width: 140},
                                    size: "large",
                                    value: i,
                                    onChange: function (t) {
                                        e.handleChangeState({categoryId: t})
                                    }
                                }, _react2.default.createElement(_select2.default.Option, {value: ""}, "璇烽€夋嫨"), t.map(function (e) {
                                    return _react2.default.createElement(_select2.default.Option, {
                                        key: e.category_id,
                                        value: e.category_id
                                    }, e.name)
                                }))), _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    label: "鎺堟潈",
                                    required: !0
                                }), _react2.default.createElement(_radio2.default.Group, {
                                    value: o, onChange: function (t) {
                                        e.handleChangeState({authorizeType: t.target.value})
                                    }
                                }, _react2.default.createElement(_radio2.default, {value: 1}, "鐙棣栧彂"), _react2.default.createElement(_radio2.default, {value: 2}, "椹荤珯浣滃搧"))), _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    help: "20-300瀛�",
                                    label: "浣滃搧浠嬬粛",
                                    required: !0
                                }), _react2.default.createElement(_input2.default.TextArea, {
                                    rows: 4,
                                    style: {resize: "none"},
                                    value: c,
                                    onChange: function (t) {
                                        e.handleChangeState({description: t.target.value})
                                    }
                                })), _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    help: "鍥剧墖灏哄600*800鍍忕礌, 涓嶈秴杩�5M鐨勫浘鐗�",
                                    label: "灏侀潰"
                                }), _react2.default.createElement(_upload2.default, {
                                    accept: ".png, .jpg, .jpeg",
                                    name: "files",
                                    withCredentials: !0,
                                    showUploadList: !1,
                                    action: _config.requestWriterBaseURL + "/image/upload/novel",
                                    beforeUpload: CreateBook.handleUploadCheck,
                                    onChange: this.handleUpload
                                }, s ? [_react2.default.createElement("img", {
                                    className: "cover",
                                    src: s
                                }), _react2.default.createElement("span", null, "淇敼")] : _react2.default.createElement("img", {
                                    style: {
                                        width: 90,
                                        cursor: "pointer",
                                        verticalAlign: "sub"
                                    }, src: "//s.weituibao.com/static/7e0wy.png"
                                }))), _react2.default.createElement(_form2.default.Item, {wrapperCol: {offset: 7}}, _react2.default.createElement(_button2.default, {
                                    style: {
                                        width: 160,
                                        marginLeft: 10
                                    }, type: "primary", size: "large", onClick: this.handlePreCheck
                                }, "鎻愪氦鍒涘缓"), _react2.default.createElement("a", {
                                    style: {color: "#778090", marginLeft: 20},
                                    onClick: function () {
                                        e.handleChangeState({currentStep: 0})
                                    }
                                }, "杩斿洖涓婁竴姝�"))) : null, 2 == r ? _react2.default.createElement("div", {className: "step-2 text-center"}, _react2.default.createElement("img", {
                                    width: "60",
                                    src: "//s.weituibao.com/static/8wvkc.png"
                                }), _react2.default.createElement("div", {className: "create-success"}, "浣滃搧鍒涘缓鎴愬姛锛�"), _react2.default.createElement("div", {className: "create-desc"}, "鏂板缓浣滃搧鍚庯紝璇峰敖蹇笂浼犳柊绔犺妭锛岀珷鑺備笂浼犳弧1500瀛椾箣鍚庡皢浼氳繘鍏ョ紪杈戝鏍�", _react2.default.createElement("br", null), "鍚庡彴锛岀紪杈戝皢浼氬湪2涓伐浣滄棩鍐呰繘琛屽鏍搞€�"), _react2.default.createElement(_reactRouterDom.Link, {to: "/book/draft?novel_id=" + u + "&chapter_id=new"}, _react2.default.createElement(_button2.default, {
                                    style: {marginTop: 30},
                                    type: "primary",
                                    size: "large"
                                }, "缁х画涓婁紶绔犺妭")), _react2.default.createElement("div", {className: "legal-notice text-left"}, "鏍规嵁鍥藉鐩稿叧娉曞緥娉曡瑕佹眰锛岃鍕夸笂浼犱换浣曡壊鎯呫€佷綆淇椼€佹秹鏀跨瓑 杩濇硶杩濊鍐呭锛屾垜浠皢浼氭牴鎹硶瑙勮繘琛屽鏍稿鐞嗗拰涓婃姤銆�")) : null)
                            }
                        }, {
                            key: "__reactstandin__regenerateByEval",
                            value: function __reactstandin__regenerateByEval(key, code) {
                                this[key] = eval(code)
                            }
                        }]), CreateBook
                    }(_react.Component)) || _class) || _class) || _class), reactHotLoader, leaveModule;
            exports.default = CreateBook, reactHotLoader = __webpack_require__(7).default, leaveModule = __webpack_require__(7).leaveModule, reactHotLoader && (reactHotLoader.register(CreateBook, "CreateBook", "/Users/yunsheng/company_project/writer/src/containers/CreateBook/index.js"), leaveModule(module))
        }).call(this, __webpack_require__(12)(module))
    }, 831: function (e, t, a) {
        "use strict";
        a.r(t);
        var r = a(2), l = a.n(r), n = a(10), i = a.n(n), o = a(17), c = a.n(o), s = a(4), u = a.n(s), _ = a(8),
            d = a.n(_), p = a(3), f = a.n(p), m = a(5), h = a.n(m), g = a(1), y = a.n(g), b = a(0), v = a.n(b),
            k = a(11), w = a(9), C = a.n(w), E = a(384), q = a.n(E);

        function x() {
            if ("undefined" != typeof window && window.document && window.document.documentElement) {
                var e = window.document.documentElement;
                return "flex" in e.style || "webkitFlex" in e.style || "Flex" in e.style || "msFlex" in e.style
            }
            return !1
        }

        var S = function (e) {
            function t(e) {
                u()(this, t);
                var a = f()(this, (t.__proto__ || Object.getPrototypeOf(t)).call(this, e));
                return a.calcStepOffsetWidth = function () {
                    if (!x()) {
                        var e = Object(k.findDOMNode)(a);
                        e.children.length > 0 && (a.calcTimeout && clearTimeout(a.calcTimeout), a.calcTimeout = setTimeout(function () {
                            var t = (e.lastChild.offsetWidth || 0) + 1;
                            a.state.lastStepOffsetWidth === t || Math.abs(a.state.lastStepOffsetWidth - t) <= 3 || a.setState({lastStepOffsetWidth: t})
                        }))
                    }
                }, a.state = {
                    flexSupported: !0,
                    lastStepOffsetWidth: 0
                }, a.calcStepOffsetWidth = q()(a.calcStepOffsetWidth, 150), a
            }

            return h()(t, e), d()(t, [{
                key: "componentDidMount", value: function () {
                    this.calcStepOffsetWidth(), x() || this.setState({flexSupported: !1})
                }
            }, {
                key: "componentDidUpdate", value: function () {
                    this.calcStepOffsetWidth()
                }
            }, {
                key: "componentWillUnmount", value: function () {
                    this.calcTimeout && clearTimeout(this.calcTimeout), this.calcStepOffsetWidth && this.calcStepOffsetWidth.cancel && this.calcStepOffsetWidth.cancel()
                }
            }, {
                key: "render", value: function () {
                    var e, t = this.props, a = t.prefixCls, r = t.style, n = void 0 === r ? {} : r, o = t.className,
                        s = t.children, u = t.direction, _ = t.labelPlacement, d = t.iconPrefix, p = t.status,
                        f = t.size, m = t.current, h = t.progressDot,
                        b = c()(t, ["prefixCls", "style", "className", "children", "direction", "labelPlacement", "iconPrefix", "status", "size", "current", "progressDot"]),
                        v = this.state, k = v.lastStepOffsetWidth, w = v.flexSupported,
                        E = y.a.Children.toArray(s).filter(function (e) {
                            return !!e
                        }), q = E.length - 1, x = h ? "vertical" : _,
                        S = C()(a, a + "-" + u, o, (e = {}, i()(e, a + "-" + f, f), i()(e, a + "-label-" + x, "horizontal" === u), i()(e, a + "-dot", !!h), e));
                    return y.a.createElement("div", l()({
                        className: S,
                        style: n
                    }, b), g.Children.map(E, function (e, t) {
                        if (!e)return null;
                        var r = l()({
                            stepNumber: "" + (t + 1),
                            prefixCls: a,
                            iconPrefix: d,
                            wrapperStyle: n,
                            progressDot: h
                        }, e.props);
                        return w || "vertical" === u || t === q || (r.itemWidth = 100 / q + "%", r.adjustMarginRight = -Math.round(k / q + 1)), "error" === p && t === m - 1 && (r.className = a + "-next-error"), e.props.status || (r.status = t === m ? p : t < m ? "finish" : "wait"), Object(g.cloneElement)(e, r)
                    }))
                }
            }]), t
        }(g.Component);
        S.propTypes = {
            prefixCls: v.a.string,
            className: v.a.string,
            iconPrefix: v.a.string,
            direction: v.a.string,
            labelPlacement: v.a.string,
            children: v.a.any,
            status: v.a.string,
            size: v.a.string,
            progressDot: v.a.oneOfType([v.a.bool, v.a.func]),
            style: v.a.object,
            current: v.a.number
        }, S.defaultProps = {
            prefixCls: "rc-steps",
            iconPrefix: "rc",
            direction: "horizontal",
            labelPlacement: "horizontal",
            current: 0,
            status: "process",
            size: "",
            progressDot: !1
        };
        var N = S;

        function O(e) {
            return "string" == typeof e
        }

        var R = function (e) {
            function t() {
                return u()(this, t), f()(this, (t.__proto__ || Object.getPrototypeOf(t)).apply(this, arguments))
            }

            return h()(t, e), d()(t, [{
                key: "renderIconNode", value: function () {
                    var e, t = this.props, a = t.prefixCls, r = t.progressDot, l = t.stepNumber, n = t.status,
                        o = t.title, c = t.description, s = t.icon, u = t.iconPrefix,
                        _ = C()(a + "-icon", u + "icon", (e = {}, i()(e, u + "icon-" + s, s && O(s)), i()(e, u + "icon-check", !s && "finish" === n), i()(e, u + "icon-cross", !s && "error" === n), e)),
                        d = y.a.createElement("span", {className: a + "-icon-dot"});
                    return r ? "function" == typeof r ? y.a.createElement("span", {className: a + "-icon"}, r(d, {
                        index: l - 1,
                        status: n,
                        title: o,
                        description: c
                    })) : y.a.createElement("span", {className: a + "-icon"}, d) : s && !O(s) ? y.a.createElement("span", {className: a + "-icon"}, s) : s || "finish" === n || "error" === n ? y.a.createElement("span", {className: _}) : y.a.createElement("span", {className: a + "-icon"}, l)
                }
            }, {
                key: "render", value: function () {
                    var e = this.props, t = e.className, a = e.prefixCls, r = e.style, n = e.itemWidth, o = e.status,
                        s = void 0 === o ? "wait" : o, u = (e.iconPrefix, e.icon),
                        _ = (e.wrapperStyle, e.adjustMarginRight), d = (e.stepNumber, e.description), p = e.title,
                        f = (e.progressDot, e.tailContent),
                        m = c()(e, ["className", "prefixCls", "style", "itemWidth", "status", "iconPrefix", "icon", "wrapperStyle", "adjustMarginRight", "stepNumber", "description", "title", "progressDot", "tailContent"]),
                        h = C()(a + "-item", a + "-item-" + s, t, i()({}, a + "-item-custom", u)), g = l()({}, r);
                    return n && (g.width = n), _ && (g.marginRight = _), y.a.createElement("div", l()({}, m, {
                        className: h,
                        style: g
                    }), y.a.createElement("div", {className: a + "-item-tail"}, f), y.a.createElement("div", {className: a + "-item-icon"}, this.renderIconNode()), y.a.createElement("div", {className: a + "-item-content"}, y.a.createElement("div", {className: a + "-item-title"}, p), d && y.a.createElement("div", {className: a + "-item-description"}, d)))
                }
            }]), t
        }(y.a.Component);
        R.propTypes = {
            className: v.a.string,
            prefixCls: v.a.string,
            style: v.a.object,
            wrapperStyle: v.a.object,
            itemWidth: v.a.oneOfType([v.a.number, v.a.string]),
            status: v.a.string,
            iconPrefix: v.a.string,
            icon: v.a.node,
            adjustMarginRight: v.a.oneOfType([v.a.number, v.a.string]),
            stepNumber: v.a.string,
            description: v.a.any,
            title: v.a.any,
            progressDot: v.a.oneOfType([v.a.bool, v.a.func]),
            tailContent: v.a.any
        };
        var D = R;
        a.d(t, "Step", function () {
            return D
        }), N.Step = D;
        t.default = N
    }, 833: function (e, t, a) {
    }, 834: function (e, t, a) {
        "use strict";
        a(15), a(833)
    }, 835: function (e, t, a) {
        "use strict";
        Object.defineProperty(t, "__esModule", {value: !0});
        var r = u(a(4)), l = u(a(8)), n = u(a(3)), i = u(a(5)), o = function (e) {
            if (e && e.__esModule)return e;
            var t = {};
            if (null != e)for (var a in e)Object.prototype.hasOwnProperty.call(e, a) && (t[a] = e[a]);
            return t.default = e, t
        }(a(1)), c = u(a(0)), s = u(a(831));

        function u(e) {
            return e && e.__esModule ? e : {default: e}
        }

        var _ = function (e) {
            function t() {
                return (0, r.default)(this, t), (0, n.default)(this, (t.__proto__ || Object.getPrototypeOf(t)).apply(this, arguments))
            }

            return (0, i.default)(t, e), (0, l.default)(t, [{
                key: "render", value: function () {
                    return o.createElement(s.default, this.props)
                }
            }]), t
        }(o.Component);
        t.default = _, _.Step = s.default.Step, _.defaultProps = {
            prefixCls: "ant-steps",
            iconPrefix: "ant",
            current: 0
        }, _.propTypes = {
            prefixCls: c.default.string,
            iconPrefix: c.default.string,
            current: c.default.number
        }, e.exports = t.default
    }, 837: function (e, t, a) {
    }
}]);
/**
 * Created by Administrator on 2018/10/25.
 */
