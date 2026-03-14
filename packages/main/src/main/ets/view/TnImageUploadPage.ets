/**
 * @file TnImageUpload 图片上传展示页面视图
 * @author JunBin.Yang
 */
import { AppNavDestination } from "@core/components";
import {
  ColumnBase,
  MediumPaddingVerticalScroll,
  P100,
  SpaceVerticalLarge,
  SpaceVerticalMedium
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { LengthMetrics } from "@kit.ArkUI";
import { TnImageUpload, TnUploadFile } from "@tuniao/tn-ui";
import TnImageUploadViewModel from "../viewmodel/TnImageUploadViewModel";

/**
 * TnImageUpload 图片上传展示页面
 */
@ComponentV2
export struct TnImageUploadPage {
  /**
   * 图片上传展示页面 ViewModel
   */
  @Local
  private vm: TnImageUploadViewModel = new TnImageUploadViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建图片上传展示页面
   */
  build() {
    AppNavDestination({
      title: "图片上传",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.PageContent();
    }
  }

  /**
   * 页面内容视图
   */
  @Builder
  private PageContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 1. 基础用法
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        this.BasicSection();

        SpaceVerticalLarge();

        // 2. 限制数量
        this.SectionTitle("限制数量");
        SpaceVerticalMedium();
        this.MaxCountSection();

        SpaceVerticalLarge();

        // 3. 禁用状态
        this.SectionTitle("禁用状态");
        SpaceVerticalMedium();
        this.DisabledSection();

        SpaceVerticalLarge();

        // 4. 模拟上传状态
        this.SectionTitle("模拟上传状态");
        SpaceVerticalMedium();
        this.UploadStatusSection();

        SpaceVerticalLarge();

        // 5. 自定义上传按钮
        this.SectionTitle("自定义上传按钮");
        SpaceVerticalMedium();
        this.CustomButtonSection();
      };
    };
  }

  /**
   * 区域标题
   * @param title 标题文本
   */
  @Builder
  private SectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.headline_medium"))
      .fontColor($r("app.color.text_primary"))
      .fontWeight(FontWeight.Bold);
  }

  /**
   * 1. 基础用法展示区
   */
  @Builder
  private BasicSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 fileList 绑定已上传的文件列表，onChoose 处理新增文件，onDelete 处理删除文件")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnImageUpload({
          fileList: this.vm.fileList,
          onChoose: (files: TnUploadFile[]) => {
            this.vm.addFiles(files);
          },
          onDelete: (file: TnUploadFile, index: number) => {
            this.vm.deleteFile(index);
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 2. 限制数量展示区
   */
  @Builder
  private MaxCountSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 maxCount 限制最多可上传的图片数量，超出后上传按钮自动隐藏，multiple 设置多选")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnImageUpload({
          fileList: this.vm.fileList,
          maxCount: 3,
          multiple: true,
          onChoose: (files: TnUploadFile[]) => {
            this.vm.addFiles(files);
          },
          onDelete: (file: TnUploadFile, index: number) => {
            this.vm.deleteFile(index);
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 3. 禁用状态展示区
   */
  @Builder
  private DisabledSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 disabled 禁用图片上传组件，禁用后无法选择或删除图片")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnImageUpload({
          fileList: this.vm.fileList,
          disabled: true,
          onChoose: (files: TnUploadFile[]) => {
            this.vm.addFiles(files);
          },
          onDelete: (file: TnUploadFile, index: number) => {
            this.vm.deleteFile(index);
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 4. 模拟上传状态展示区
   */
  @Builder
  private UploadStatusSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("选择图片后模拟上传过程，展示上传中的加载动画和进度，上传完成后随机展示成功或失败状态（约 50% 概率失败）")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnImageUpload({
          fileList: this.vm.uploadDemoFileList,
          onChoose: (files: TnUploadFile[]) => {
            this.vm.addFilesWithUpload(files);
          },
          onDelete: (file: TnUploadFile, index: number) => {
            this.vm.deleteUploadDemoFile(index);
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 5. 自定义上传按钮展示区
   */
  @Builder
  private CustomButtonSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 uploadIcon 和 uploadText 自定义上传按钮的图标和文字")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnImageUpload({
          fileList: this.vm.fileList,
          uploadIcon: "camera",
          uploadText: "拍照上传",
          previewImage: true,
          onChoose: (files: TnUploadFile[]) => {
            this.vm.addFiles(files);
          },
          onDelete: (file: TnUploadFile, index: number) => {
            this.vm.deleteFile(index);
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
