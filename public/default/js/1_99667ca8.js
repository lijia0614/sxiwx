(window.webpackJsonp = window.webpackJsonp || []).push([[1], {
    830: function (module, exports, __webpack_require__) {
        "use strict";
        (function (module) {
            Object.defineProperty(exports, "__esModule", {value: !0}), exports.default = void 0;
            var _select = __webpack_require__(55), _select2 = _interopRequireDefault(_select),
                _radio = __webpack_require__(109), _radio2 = _interopRequireDefault(_radio),
                _button = __webpack_require__(27), _button2 = _interopRequireDefault(_button),
                _form = __webpack_require__(75), _form2 = _interopRequireDefault(_form),
                _input = __webpack_require__(46), _input2 = _interopRequireDefault(_input),
                _row = __webpack_require__(160), _row2 = _interopRequireDefault(_row), _col = __webpack_require__(159),
                _col2 = _interopRequireDefault(_col), _steps = __webpack_require__(835),
                _steps2 = _interopRequireDefault(_steps), _extends2 = __webpack_require__(2),
                _extends3 = _interopRequireDefault(_extends2), _message2 = __webpack_require__(40),
                _message3 = _interopRequireDefault(_message2), _getPrototypeOf = __webpack_require__(19),
                _getPrototypeOf2 = _interopRequireDefault(_getPrototypeOf), _classCallCheck2 = __webpack_require__(4),
                _classCallCheck3 = _interopRequireDefault(_classCallCheck2), _createClass2 = __webpack_require__(8),
                _createClass3 = _interopRequireDefault(_createClass2),
                _possibleConstructorReturn2 = __webpack_require__(3),
                _possibleConstructorReturn3 = _interopRequireDefault(_possibleConstructorReturn2),
                _inherits2 = __webpack_require__(5), _inherits3 = _interopRequireDefault(_inherits2), _dec, _class;
            __webpack_require__(65), __webpack_require__(161), __webpack_require__(28), __webpack_require__(74), __webpack_require__(31), __webpack_require__(158), __webpack_require__(157), __webpack_require__(834), __webpack_require__(39);
            var _react = __webpack_require__(1), _react2 = _interopRequireDefault(_react),
                _mobxReact = __webpack_require__(24), _reactRouterDom = __webpack_require__(22),
                _writer = __webpack_require__(23), writerApis = _interopRequireWildcard(_writer), enterModule;

            function _interopRequireWildcard(e) {
                if (e && e.__esModule)return e;
                var t = {};
                if (null != e)for (var a in e)Object.prototype.hasOwnProperty.call(e, a) && (t[a] = e[a]);
                return t.default = e, t
            }

            function _interopRequireDefault(e) {
                return e && e.__esModule ? e : {default: e}
            }

            __webpack_require__(839), enterModule = __webpack_require__(7).enterModule, enterModule && enterModule(module);
            var Apply = (_dec = (0, _mobxReact.inject)("userStore"), _dec(_class = (0, _reactRouterDom.withRouter)(_class = (0, _mobxReact.observer)(_class = function (_Component) {
                        function Apply(e) {
                            (0, _classCallCheck3.default)(this, Apply);
                            var t = (0, _possibleConstructorReturn3.default)(this, (Apply.__proto__ || (0, _getPrototypeOf2.default)(Apply)).call(this, e));
                            return t.handleChangeState = t.handleChangeState.bind(t), t.handleCheckForm0 = t.handleCheckForm0.bind(t), t.handleCheckForm1 = t.handleCheckForm1.bind(t), t.handleSelectArea = t.handleSelectArea.bind(t), t.handleApply = t.handleApply.bind(t), t.state = {
                                currentStep: 0,
                                penname: null,
                                qq: null,
                                weixin: null,
                                truename: null,
                                sex: 0,
                                idCard: null,
                                areaData: {
                                    province: window.tdist.getLev1(),
                                    city: [],
                                    dist: [],
                                    provinceId: "",
                                    cityId: "",
                                    areaId: ""
                                },
                                address: null
                            }, t
                        }

                        return (0, _inherits3.default)(Apply, _Component), (0, _createClass3.default)(Apply, [{
                            key: "handleChangeState",
                            value: function (e) {
                                this.setState(e)
                            }
                        }, {
                            key: "handleCheckForm0", value: function () {
                                var e = this.state, t = e.penname, a = e.qq;
                                t && /^\S{2,10}$/g.test(t) ? a && /^[1-9]\d{4,12}$/g.test(a) ? this.setState({currentStep: 1}) : _message3.default.error("璇锋鏌Q鍙�") : _message3.default.error("璇锋鏌ョ瑪鍚�")
                            }
                        }, {
                            key: "handleCheckForm1", value: function () {
                                var e = this.state, t = e.truename, a = e.sex, r = e.idCard, n = e.areaData,
                                    l = e.address, i = 442e3 != n.cityId && 441900 != n.cityId && !n.areaId;
                                t ? a ? r && /(^\d{15}$)|(^\d{17}([0-9]|X)$)/g.test(r) ? i ? _message3.default.error("璇锋鏌ユ墍鍦ㄥ湴鍖�") : l ? this.handleApply() : _message3.default.error("璇锋鏌ヨ缁嗗湴鍧€") : _message3.default.error("璇锋鏌ヨ韩浠借瘉鍙�") : _message3.default.error("璇锋鏌ユ€у埆") : _message3.default.error("璇锋鏌ョ湡瀹炲鍚�")
                            }
                        }, {
                            key: "handleSelectArea", value: function (e, t) {
                                var a = this.state.areaData, r = {};
                                1 === t ? r = (0, _extends3.default)({}, a, {
                                    city: window.tdist.getLev2(e),
                                    dist: [],
                                    provinceId: e,
                                    cityId: "",
                                    areaId: ""
                                }) : 2 === t ? r = (0, _extends3.default)({}, a, {
                                    dist: window.tdist.getLev3(e),
                                    cityId: e,
                                    areaId: ""
                                }) : 3 === t && (r = (0, _extends3.default)({}, a, {areaId: e})), this.setState({areaData: r})
                            }
                        }, {
                            key: "handleApply", value: function () {
                                var e = this, t = this.props, a = t.userStore.getInfo, r = t.history, n = this.state,
                                    l = n.penname, i = n.qq, s = n.weixin, c = n.truename, u = n.sex, o = n.idCard,
                                    _ = n.areaData, d = n.address;
                                writerApis.applyWriter({
                                    penname: l,
                                    qq: i,
                                    weixin: s,
                                    truename: c,
                                    sex: u,
                                    idCard: o,
                                    provinceId: _.provinceId,
                                    cityId: _.cityId,
                                    areaId: _.areaId,
                                    address: d
                                }).then(function (t) {
                                    e.setState({currentStep: 2}), setTimeout(function () {
                                        a({history: r})
                                    }, 3e3)
                                })
                            }
                        }, {
                            key: "render", value: function () {
                                var e = this, t = this.state, a = t.currentStep, r = t.penname, n = t.qq, l = t.weixin,
                                    i = t.truename, s = t.sex, c = t.idCard, u = t.areaData, o = t.address, _ = {
                                        labelCol: {span: 2, offset: 6},
                                        wrapperCol: {span: 9},
                                        style: {marginBottom: 30}
                                    };
                                return _react2.default.createElement("div", {className: "apply-wrap"}, _react2.default.createElement("h2", {className: "title"}, "鐢宠浣滆€�"), _react2.default.createElement(_row2.default, {style: {marginTop: 100}}, _react2.default.createElement(_col2.default, {
                                    span: 12,
                                    offset: 6
                                }, _react2.default.createElement(_steps2.default, {current: a}, _react2.default.createElement(_steps2.default.Step, {title: "鍩虹淇℃伅"}), _react2.default.createElement(_steps2.default.Step, {title: "璇︾粏淇℃伅"}), _react2.default.createElement(_steps2.default.Step, {title: "鐢宠鎴愬姛"})))), 0 == a ? _react2.default.createElement("div", {className: "step-0"}, _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    help: "2-10涓眽瀛楋紝鏁板瓧鎴栬嫳鏂囧瓧姣嶇粍鎴愶紝绗斿悕鐢宠鍚庝笉鍙彉鏇�",
                                    label: "绗斿悕",
                                    required: !0
                                }), _react2.default.createElement(_input2.default, {
                                    size: "large",
                                    value: r,
                                    onChange: function (t) {
                                        e.handleChangeState({penname: t.target.value})
                                    }
                                })), _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    help: "璇峰～鍐欏父鐢ㄧ殑QQ鍙风爜锛屼究浜庣紪杈戝揩閫熻仈绯诲埌鎮�",
                                    label: "QQ",
                                    required: !0
                                }), _react2.default.createElement(_input2.default, {
                                    size: "large",
                                    value: n,
                                    onChange: function (t) {
                                        e.handleChangeState({qq: t.target.value})
                                    }
                                })), _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    help: "璇峰～鍐欏父鐢ㄧ殑寰俊鍙风爜锛屼究浜庣紪杈戝揩閫熻仈绯诲埌鎮�",
                                    label: "寰俊"
                                }), _react2.default.createElement(_input2.default, {
                                    size: "large",
                                    value: l,
                                    onChange: function (t) {
                                        e.handleChangeState({weixin: t.target.value})
                                    }
                                })), _react2.default.createElement(_form2.default.Item, {wrapperCol: {offset: 8}}, _react2.default.createElement(_button2.default, {
                                    style: {width: 160},
                                    type: "primary",
                                    size: "large",
                                    onClick: this.handleCheckForm0
                                }, "涓嬩竴姝�"))) : null, 1 == a ? _react2.default.createElement("div", {className: "step-1"}, _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    label: "鐪熷疄濮撳悕",
                                    required: !0
                                }), _react2.default.createElement(_input2.default, {
                                    size: "large",
                                    value: i,
                                    onChange: function (t) {
                                        e.handleChangeState({truename: t.target.value})
                                    }
                                })), _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    label: "鎬у埆",
                                    required: !0
                                }), _react2.default.createElement(_radio2.default.Group, {
                                    value: s, onChange: function (t) {
                                        e.handleChangeState({sex: t.target.value})
                                    }
                                }, _react2.default.createElement(_radio2.default, {value: 1}, "鐢�"), _react2.default.createElement(_radio2.default, {value: 2}, "濂�"))), _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    label: "韬唤璇佸彿",
                                    required: !0
                                }), _react2.default.createElement(_input2.default, {
                                    size: "large",
                                    value: c,
                                    onChange: function (t) {
                                        e.handleChangeState({idCard: t.target.value})
                                    }
                                })), _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    label: "鎵€鍦ㄥ湴鍖�",
                                    required: !0
                                }), _react2.default.createElement(_select2.default, {
                                    style: {width: 138},
                                    size: "large",
                                    value: u.provinceId,
                                    onChange: function (t) {
                                        e.handleSelectArea(t, 1)
                                    }
                                }, _react2.default.createElement(_select2.default.Option, {value: ""}, "璇烽€夋嫨"), u.province.map(function (e) {
                                    return _react2.default.createElement(_select2.default.Option, {
                                        key: e.id,
                                        value: e.id
                                    }, e.text)
                                })), _react2.default.createElement(_select2.default, {
                                    style: {width: 138, marginLeft: 10},
                                    size: "large",
                                    value: u.cityId,
                                    onChange: function (t) {
                                        e.handleSelectArea(t, 2)
                                    }
                                }, _react2.default.createElement(_select2.default.Option, {value: ""}, "璇烽€夋嫨"), u.city.map(function (e) {
                                    return _react2.default.createElement(_select2.default.Option, {
                                        key: e.id,
                                        value: e.id
                                    }, e.text)
                                })), 442e3 == u.cityId || 441900 == u.cityId ? null : _react2.default.createElement(_select2.default, {
                                    style: {
                                        width: 138,
                                        marginLeft: 10
                                    }, size: "large", value: u.areaId, onChange: function (t) {
                                        e.handleSelectArea(t, 3)
                                    }
                                }, _react2.default.createElement(_select2.default.Option, {value: ""}, "璇烽€夋嫨"), u.dist.map(function (e) {
                                    return _react2.default.createElement(_select2.default.Option, {
                                        key: e.id,
                                        value: e.id
                                    }, e.text)
                                }))), _react2.default.createElement(_form2.default.Item, (0, _extends3.default)({}, _, {
                                    help: "璇峰～鍐欏叿浣撹閬撱€佸皬鍖恒€佸崟鍏冦€佹埧闂村彿",
                                    label: "璇︾粏鍦板潃",
                                    required: !0
                                }), _react2.default.createElement(_input2.default, {
                                    size: "large",
                                    value: o,
                                    onChange: function (t) {
                                        e.handleChangeState({address: t.target.value})
                                    }
                                })), _react2.default.createElement(_form2.default.Item, {wrapperCol: {offset: 8}}, _react2.default.createElement(_button2.default, {
                                    style: {width: 160},
                                    type: "primary",
                                    size: "large",
                                    onClick: this.handleCheckForm1
                                }, "鎻愪氦鐢宠"), _react2.default.createElement("a", {
                                    style: {color: "#778090", marginLeft: 20},
                                    onClick: function () {
                                        e.handleChangeState({currentStep: 0})
                                    }
                                }, "杩斿洖涓婁竴姝�"))) : null, 2 == a ? _react2.default.createElement("div", {className: "step-2 text-center"}, _react2.default.createElement("img", {
                                    width: "60",
                                    src: "//s.weituibao.com/static/8wvkc.png"
                                }), _react2.default.createElement("div", {
                                    style: {
                                        marginTop: 13,
                                        fontSize: 18,
                                        color: "#444e5e"
                                    }
                                }, "鐢宠浣滆€呮垚鍔�"), _react2.default.createElement("div", {
                                    style: {
                                        marginTop: 10,
                                        color: "#b0b5bd"
                                    }
                                }, "3S鍚庣郴缁熻嚜鍔ㄨ烦杞紝濡傛灉娌℃湁璺宠浆璇锋墜鍔� ", _react2.default.createElement(_reactRouterDom.Link, {
                                    style: {color: "#4990e2"},
                                    to: "/home"
                                }, "鐐瑰嚮璺宠浆"))) : null)
                            }
                        }, {
                            key: "__reactstandin__regenerateByEval",
                            value: function __reactstandin__regenerateByEval(key, code) {
                                this[key] = eval(code)
                            }
                        }]), Apply
                    }(_react.Component)) || _class) || _class) || _class), reactHotLoader, leaveModule;
            exports.default = Apply, reactHotLoader = __webpack_require__(7).default, leaveModule = __webpack_require__(7).leaveModule, reactHotLoader && (reactHotLoader.register(Apply, "Apply", "/Users/yunsheng/company_project/writer/src/containers/Apply/index.js"), leaveModule(module))
        }).call(this, __webpack_require__(12)(module))
    }, 831: function (e, t, a) {
        "use strict";
        a.r(t);
        var r = a(2), n = a.n(r), l = a(10), i = a.n(l), s = a(17), c = a.n(s), u = a(4), o = a.n(u), _ = a(8),
            d = a.n(_), p = a(3), f = a.n(p), m = a(5), h = a.n(m), y = a(1), g = a.n(y), v = a(0), b = a.n(v),
            w = a(11), C = a(9), k = a.n(C), q = a(384), x = a.n(q);

        function E() {
            if ("undefined" != typeof window && window.document && window.document.documentElement) {
                var e = window.document.documentElement;
                return "flex" in e.style || "webkitFlex" in e.style || "Flex" in e.style || "msFlex" in e.style
            }
            return !1
        }

        var S = function (e) {
            function t(e) {
                o()(this, t);
                var a = f()(this, (t.__proto__ || Object.getPrototypeOf(t)).call(this, e));
                return a.calcStepOffsetWidth = function () {
                    if (!E()) {
                        var e = Object(w.findDOMNode)(a);
                        e.children.length > 0 && (a.calcTimeout && clearTimeout(a.calcTimeout), a.calcTimeout = setTimeout(function () {
                            var t = (e.lastChild.offsetWidth || 0) + 1;
                            a.state.lastStepOffsetWidth === t || Math.abs(a.state.lastStepOffsetWidth - t) <= 3 || a.setState({lastStepOffsetWidth: t})
                        }))
                    }
                }, a.state = {
                    flexSupported: !0,
                    lastStepOffsetWidth: 0
                }, a.calcStepOffsetWidth = x()(a.calcStepOffsetWidth, 150), a
            }

            return h()(t, e), d()(t, [{
                key: "componentDidMount", value: function () {
                    this.calcStepOffsetWidth(), E() || this.setState({flexSupported: !1})
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
                    var e, t = this.props, a = t.prefixCls, r = t.style, l = void 0 === r ? {} : r, s = t.className,
                        u = t.children, o = t.direction, _ = t.labelPlacement, d = t.iconPrefix, p = t.status,
                        f = t.size, m = t.current, h = t.progressDot,
                        v = c()(t, ["prefixCls", "style", "className", "children", "direction", "labelPlacement", "iconPrefix", "status", "size", "current", "progressDot"]),
                        b = this.state, w = b.lastStepOffsetWidth, C = b.flexSupported,
                        q = g.a.Children.toArray(u).filter(function (e) {
                            return !!e
                        }), x = q.length - 1, E = h ? "vertical" : _,
                        S = k()(a, a + "-" + o, s, (e = {}, i()(e, a + "-" + f, f), i()(e, a + "-label-" + E, "horizontal" === o), i()(e, a + "-dot", !!h), e));
                    return g.a.createElement("div", n()({
                        className: S,
                        style: l
                    }, v), y.Children.map(q, function (e, t) {
                        if (!e)return null;
                        var r = n()({
                            stepNumber: "" + (t + 1),
                            prefixCls: a,
                            iconPrefix: d,
                            wrapperStyle: l,
                            progressDot: h
                        }, e.props);
                        return C || "vertical" === o || t === x || (r.itemWidth = 100 / x + "%", r.adjustMarginRight = -Math.round(w / x + 1)), "error" === p && t === m - 1 && (r.className = a + "-next-error"), e.props.status || (r.status = t === m ? p : t < m ? "finish" : "wait"), Object(y.cloneElement)(e, r)
                    }))
                }
            }]), t
        }(y.Component);
        S.propTypes = {
            prefixCls: b.a.string,
            className: b.a.string,
            iconPrefix: b.a.string,
            direction: b.a.string,
            labelPlacement: b.a.string,
            children: b.a.any,
            status: b.a.string,
            size: b.a.string,
            progressDot: b.a.oneOfType([b.a.bool, b.a.func]),
            style: b.a.object,
            current: b.a.number
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
        var O = S;

        function D(e) {
            return "string" == typeof e
        }

        var I = function (e) {
            function t() {
                return o()(this, t), f()(this, (t.__proto__ || Object.getPrototypeOf(t)).apply(this, arguments))
            }

            return h()(t, e), d()(t, [{
                key: "renderIconNode", value: function () {
                    var e, t = this.props, a = t.prefixCls, r = t.progressDot, n = t.stepNumber, l = t.status,
                        s = t.title, c = t.description, u = t.icon, o = t.iconPrefix,
                        _ = k()(a + "-icon", o + "icon", (e = {}, i()(e, o + "icon-" + u, u && D(u)), i()(e, o + "icon-check", !u && "finish" === l), i()(e, o + "icon-cross", !u && "error" === l), e)),
                        d = g.a.createElement("span", {className: a + "-icon-dot"});
                    return r ? "function" == typeof r ? g.a.createElement("span", {className: a + "-icon"}, r(d, {
                        index: n - 1,
                        status: l,
                        title: s,
                        description: c
                    })) : g.a.createElement("span", {className: a + "-icon"}, d) : u && !D(u) ? g.a.createElement("span", {className: a + "-icon"}, u) : u || "finish" === l || "error" === l ? g.a.createElement("span", {className: _}) : g.a.createElement("span", {className: a + "-icon"}, n)
                }
            }, {
                key: "render", value: function () {
                    var e = this.props, t = e.className, a = e.prefixCls, r = e.style, l = e.itemWidth, s = e.status,
                        u = void 0 === s ? "wait" : s, o = (e.iconPrefix, e.icon),
                        _ = (e.wrapperStyle, e.adjustMarginRight), d = (e.stepNumber, e.description), p = e.title,
                        f = (e.progressDot, e.tailContent),
                        m = c()(e, ["className", "prefixCls", "style", "itemWidth", "status", "iconPrefix", "icon", "wrapperStyle", "adjustMarginRight", "stepNumber", "description", "title", "progressDot", "tailContent"]),
                        h = k()(a + "-item", a + "-item-" + u, t, i()({}, a + "-item-custom", o)), y = n()({}, r);
                    return l && (y.width = l), _ && (y.marginRight = _), g.a.createElement("div", n()({}, m, {
                        className: h,
                        style: y
                    }), g.a.createElement("div", {className: a + "-item-tail"}, f), g.a.createElement("div", {className: a + "-item-icon"}, this.renderIconNode()), g.a.createElement("div", {className: a + "-item-content"}, g.a.createElement("div", {className: a + "-item-title"}, p), d && g.a.createElement("div", {className: a + "-item-description"}, d)))
                }
            }]), t
        }(g.a.Component);
        I.propTypes = {
            className: b.a.string,
            prefixCls: b.a.string,
            style: b.a.object,
            wrapperStyle: b.a.object,
            itemWidth: b.a.oneOfType([b.a.number, b.a.string]),
            status: b.a.string,
            iconPrefix: b.a.string,
            icon: b.a.node,
            adjustMarginRight: b.a.oneOfType([b.a.number, b.a.string]),
            stepNumber: b.a.string,
            description: b.a.any,
            title: b.a.any,
            progressDot: b.a.oneOfType([b.a.bool, b.a.func]),
            tailContent: b.a.any
        };
        var R = I;
        a.d(t, "Step", function () {
            return R
        }), O.Step = R;
        t.default = O
    }, 833: function (e, t, a) {
    }, 834: function (e, t, a) {
        "use strict";
        a(15), a(833)
    }, 835: function (e, t, a) {
        "use strict";
        Object.defineProperty(t, "__esModule", {value: !0});
        var r = o(a(4)), n = o(a(8)), l = o(a(3)), i = o(a(5)), s = function (e) {
            if (e && e.__esModule)return e;
            var t = {};
            if (null != e)for (var a in e)Object.prototype.hasOwnProperty.call(e, a) && (t[a] = e[a]);
            return t.default = e, t
        }(a(1)), c = o(a(0)), u = o(a(831));

        function o(e) {
            return e && e.__esModule ? e : {default: e}
        }

        var _ = function (e) {
            function t() {
                return (0, r.default)(this, t), (0, l.default)(this, (t.__proto__ || Object.getPrototypeOf(t)).apply(this, arguments))
            }

            return (0, i.default)(t, e), (0, n.default)(t, [{
                key: "render", value: function () {
                    return s.createElement(u.default, this.props)
                }
            }]), t
        }(s.Component);
        t.default = _, _.Step = u.default.Step, _.defaultProps = {
            prefixCls: "ant-steps",
            iconPrefix: "ant",
            current: 0
        }, _.propTypes = {
            prefixCls: c.default.string,
            iconPrefix: c.default.string,
            current: c.default.number
        }, e.exports = t.default
    }, 839: function (e, t, a) {
    }
}]);
/**
 * Created by Administrator on 2018/10/25.
 */
