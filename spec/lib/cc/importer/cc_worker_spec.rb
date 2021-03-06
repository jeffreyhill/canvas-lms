#
# Copyright (C) 2011 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper.rb')

describe Canvas::Migration::Worker::CCWorker do
  it "should set the worker_class on the migration" do
    cm = ContentMigration.create!(:migration_settings => { :no_archive_file => true })
    Canvas::Migration::Worker.expects(:get_converter).with(anything).returns(CC::Importer::Canvas::Converter)
    CC::Importer::Canvas::Converter.any_instance.expects(:export).returns({})
    worker = Canvas::Migration::Worker::CCWorker.new(cm.id)
    worker.perform().should == true
    cm.reload.migration_settings[:worker_class].should == 'CC::Importer::Canvas::Converter'
  end
end
